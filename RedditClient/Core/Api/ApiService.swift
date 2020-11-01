//
//  ApiService.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

enum ApiResponse<T: Decodable> {
    case success(T)
    case failure(Error)
}

class ApiService {
    
    fileprivate let baseUrl: URL
    fileprivate let session: URLSession
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
        session = URLSession(configuration: .default)
    }
    
    func perform<T: Decodable>(request: ApiRequest, completion: @escaping (ApiResponse<T>) -> Void) -> ApiCall {
        let url = baseUrl.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        switch request.httpMethod {
        case .get:
            if let dictionary = request.encodedData?.asDictionary, var urlComponents = URLComponents(string: url.absoluteString) {
                urlComponents.queryItems = dictionary.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponents.url
            }
        case .post, .put, .patch, .delete:
            urlRequest.httpBody = request.encodedData
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let decoded = try decoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            
            } else if let error = error {
                completion(.failure(error))
            } else {
                let error = ApiError(message: "Unexpected response without data nor error.")
                completion(.failure(error))
            }
        }
        task.resume()
        return task
    }
}

// MARK: - Utility
private extension ApiRequest {
    
    var encodedData: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}

private extension Data {
    var asDictionary: [String: Any]? {
      return try? JSONSerialization.jsonObject(with: self, options: [.mutableContainers]) as? [String: Any]
    }
  }
