//
//  MockService.swift
//  Clear Score CreditTests
//
//  Created by Haresh Ghatala on 9/2/22.
//

import XCTest
@testable import Clear_Score_Credit

class MockService: Service {
    
    public static let mockShared = MockService()
    override init() {
        super.init()
    }
    
    var isfailur: Bool = false
    var mockServiceError: ServiceError?
    var mockResponse: Credit?
    
    override func fetchResources<T>(url: URL, queryParams: [String : String]? = nil, completion: @escaping (Result<T, ServiceError>) -> Void) where T : Decodable {
        if isfailur {
            completion(.failure(mockServiceError!))
        } else {
            completion(.success(mockResponse as! T))
        }
    }
    
}

