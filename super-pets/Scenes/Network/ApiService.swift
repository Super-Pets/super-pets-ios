import Foundation

enum ApiError: Error {
    case invalidURL,
         requestError(description: String),
         invalidResponse,
         invalidData,
         decodingError(description: String)
}

enum TypeOfInformation {
    case register
    case adoptables
    
    var baseURL: String {
        "https://www.aindanaotem.com"
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "/registerEndpoint"
        case .adoptables:
            return "/adoptablesEndpoint"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(endPoint)")
    }
    
    var hTTPMethod: String {
        switch self {
        case .register:
            return "POST"
        case .adoptables:
            return "GET"
        }
    }
}

protocol ApiServiceProtocol {
    func fetchAdoptables(completion: @escaping (Result<[AnimalsModel], ApiError>) -> Void)
    func registerAnimal(animal: RegisterAnimalParams, completion: @escaping (Result<RegisterCompletedModel, ApiError>) -> Void)
}

final class ApiService: ApiServiceProtocol {
    func fetchAdoptables(completion: @escaping (Result<[AnimalsModel], ApiError>) -> Void) {
        fetchData(info: .adoptables, body: nil, completion: completion)
    }
    
    func registerAnimal(animal: RegisterAnimalParams, completion: @escaping (Result<RegisterCompletedModel, ApiError>) -> Void) {
        let body: [String: Any] = [
            "name": animal.name,
            "specie": animal.specie,
            "animalDescription": animal.animalDescription,
            "gender": animal.gender,
            "age": animal.age,
            "size": animal.size,
            "state": animal.state,
            "vaccine": animal.vaccine,
            "castration": animal.castration,
            "image": animal.image,
        ]
        
        fetchData(info: .register, body: body, completion: completion)
    }
    
    private func fetchData<T: Codable>(info: TypeOfInformation, body: [String: Any]?, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = info.url else {
            return completion(.failure(ApiError.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = info.hTTPMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body, let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) {
            request.httpBody = bodyData
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(description: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.decodingError(description: error.localizedDescription)))
            }
        }
        dataTask.resume()
    }
}
