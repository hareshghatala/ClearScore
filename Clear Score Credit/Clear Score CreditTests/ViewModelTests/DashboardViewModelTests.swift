//
//  DashboardViewModelTests.swift
//  Clear Score CreditTests
//
//  Created by Haresh Ghatala on 9/2/22.
//

import XCTest
@testable import Clear_Score_Credit

class DashboardViewModelTests: XCTestCase {
    
    var mockService: MockService!
    
    var mockReportInfo: CreditReportInfo!
    var mockData: Credit!
    
    override func setUpWithError() throws {
        mockService = MockService.mockShared
        
        mockReportInfo = CreditReportInfo(score: 200,
                                          scoreBand: 2,
                                          status: "MATCH",
                                          maxScoreValue: 700,
                                          minScoreValue: 0)
        mockData = Credit(accountIDVStatus: "PASS",
                          creditReportInfo: mockReportInfo,
                          dashboardStatus: "PASS",
                          personaType: "INEXPERIENCED")
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        mockReportInfo = nil
        mockData = nil
    }
    
    func testViewModelInitialsCorrectly() throws {
        mockService.isfailur = true
        mockService.mockServiceError = ServiceError.noData
        
        let obj = DashboardViewModel()
        obj.serviceSession = mockService
        XCTAssertNotNil(obj)
    }
    
    func testFetchCreditScoresHandledCorrectly() throws {
        mockService.isfailur = false
        mockService.mockResponse = mockData
        
        let obj = DashboardViewModel()
        obj.serviceSession = mockService
        obj.fetchCreditScores()
        
        XCTAssertNotEqual(obj.getCreditScore(), 0)
        XCTAssertNotEqual(obj.getMaxCreditScore(), 0)
        XCTAssertNotEqual(obj.getScorePercentage(), 0.0)
    }
    
    func testFetchCreditScoresFaileurForApiError() throws {
        mockService.isfailur = true
        mockService.mockServiceError = .apiError
        
        let obj = DashboardViewModel()
        obj.serviceSession = mockService
        obj.fetchCreditScores()
        
        XCTAssertEqual(obj.getCreditScore(), 0)
        XCTAssertEqual(obj.getMaxCreditScore(), 0)
        XCTAssertEqual(obj.getScorePercentage(), 0.0)
    }
    
    func testFetchCreditScoresFaileurForInvalidEndpoint() throws {
        mockService.isfailur = true
        mockService.mockServiceError = .invalidEndpoint
        
        let obj = DashboardViewModel()
        obj.serviceSession = mockService
        obj.fetchCreditScores()
        
        XCTAssertEqual(obj.getCreditScore(), 0)
        XCTAssertEqual(obj.getMaxCreditScore(), 0)
        XCTAssertEqual(obj.getScorePercentage(), 0.0)
    }
    
    func testFetchCreditScoresFaileurForInvalidResponse() throws {
        mockService.isfailur = true
        mockService.mockServiceError = .invalidResponse
        
        let obj = DashboardViewModel()
        obj.serviceSession = mockService
        obj.fetchCreditScores()
        
        XCTAssertEqual(obj.getCreditScore(), 0)
        XCTAssertEqual(obj.getMaxCreditScore(), 0)
        XCTAssertEqual(obj.getScorePercentage(), 0.0)
    }
    
    func testFetchCreditScoresFaileurForDecodeError() throws {
        mockService.isfailur = true
        mockService.mockServiceError = .decodeError
        
        let obj = DashboardViewModel()
        obj.serviceSession = mockService
        obj.fetchCreditScores()
        
        XCTAssertEqual(obj.getCreditScore(), 0)
        XCTAssertEqual(obj.getMaxCreditScore(), 0)
        XCTAssertEqual(obj.getScorePercentage(), 0.0)
    }
    
}
