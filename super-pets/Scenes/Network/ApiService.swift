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
        "http://localhost:5097"
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "/animals"
        case .adoptables:
            return "/animals"
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

final class ApiService: NSObject, ApiServiceProtocol, URLSessionDelegate {
    func fetchAdoptables(completion: @escaping (Result<[AnimalsModel], ApiError>) -> Void) {
        fetchData(info: .adoptables, body: nil, completion: completion)
    }
    
    func registerAnimal(animal: RegisterAnimalParams, completion: @escaping (Result<RegisterCompletedModel, ApiError>) -> Void) {
        let body: [String: Any] = [
            "name": animal.name,
            "species": animal.species,
            "description": animal.description,
            "gender": animal.gender,
            "age": animal.age,
            "size": animal.size,
            "local": animal.local,
            "vaccines": animal.vaccines,
            "castration": animal.castration
        ]
        
        fetchData(info: .register, body: body, completion: completion)
    }
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust {
            
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
            
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
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
        
        let dataTask = session.dataTask(with: url) { data, response, error in
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
