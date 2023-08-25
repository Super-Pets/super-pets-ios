import Foundation

enum ApiError: Error {
    case invalidURL,
         requestError(description: String),
         invalidResponse,
         invalidData,
         decodingError(description: String)
}

enum TypeOfInformation {
    case register(params: [String: String]?)
    case adoptables
    
    var baseURL: String {
        "https://www.aindanaotem.com"
    }
    
    var url: URL? {
        switch self {
        case .register(params: let params):
            guard let params = params else {
                return getUrl(of: "\(baseURL)/aindanaotem")
            }
            var urlWithParams = URLComponents(string: "\(baseURL)/aindanaotem")
            let configuredParams = setupQueryParams(using: params)
            urlWithParams?.queryItems = configuredParams
            let url = urlWithParams?.url
            return url
        case .adoptables:
            return getUrl(of: "\(baseURL)/aindanaotem")
        }
    }
    
    func setupQueryParams(using params: [String: String]) -> [URLQueryItem] {
        let queryParams: [URLQueryItem] = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        return queryParams
    }
    
    func getUrl(of value: String) -> URL? {
        URL(string: value)
    }
}

protocol ApiServiceProtocol {
    func fetchAdoptables(completion: @escaping (Result<[AnimalsModel], ApiError>) -> Void)
}

final class ApiService: ApiServiceProtocol {
    func fetchAdoptables(completion: @escaping (Result<[AnimalsModel], ApiError>) -> Void) {
        fetchData(url: TypeOfInformation.adoptables.url, completion: completion)
    }
    
    private func fetchData<T: Codable>(url: URL?, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = url else {
            return completion(.failure(ApiError.invalidURL))
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(description: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError(description: error.localizedDescription)))
            }
        }
        dataTask.resume()
    }
}
