//
//  Service.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

import Foundation

public enum ServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class Service {
    
    public static let shared = Service()
    init() {}
    
    private let urlSession = URLSession.shared
    
    private let baseURL = URL(string: baseURLString)!
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    /// Environments
    enum Environment: String {
        case prod = "prod"
    }
    
    /// Enum endpoints
    enum Endpoint: String {
        case mockcredit = "mockcredit/values"
    }
    
    private func currentEnvironment() -> String {
        return Environment.prod.rawValue
    }
    
    /// Common get service call
    func fetchResources<T: Decodable>(url: URL, queryParams: [String: String]? = nil, completion: @escaping (Result<T, ServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        if let queryParams = queryParams?.map({ URLQueryItem(name: $0.key, value: $0.value) }) {
            urlComponents.queryItems = queryParams
        }
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        print("Request Url: \(url.absoluteString)")
        urlSession.dataTask(with: url) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    print(error)
                    completion(.failure(.decodeError))
                }
                
            case .failure( _):
                completion(.failure(.apiError))
            }
        }.resume()
    }
    
    // MARK: - Service call prebuild methods
    
    public func creditScore(result: @escaping (Result<Credit, ServiceError>) -> Void) {
        var scoreURL = baseURL
        scoreURL.appendPathComponent(currentEnvironment())
        scoreURL.appendPathComponent(Endpoint.mockcredit.rawValue)
        
        fetchResources(url: scoreURL, queryParams: nil, completion: result)
    }
}
