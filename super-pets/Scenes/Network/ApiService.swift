import Foundation

enum ApiError: Error {
    case invalidURL,
         requestError(description: String),
         invalidResponse,
         invalidData,
         decodingError(description: String)
}

protocol ApiServiceProtocol {
    
}

final class ApiService: ApiServiceProtocol {
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
