//
//  DashboardViewModel.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

import Foundation
import UIKit

class DashboardViewModel {
    
    private var scoreData: Credit?
    
    var serviceSession = Service.shared
    
    var bindDataToController: (() -> ()) = {}
    var serviceFailur: (() -> ()) = {}
    
    init() {
        fetchCreditScores()
    }
    
    // MARK: -  Network calls
    
    func fetchCreditScores() {
        ProgressHUD.show(interaction: false)
        serviceSession.creditScore { (result: Result<Credit, ServiceError>) in
            switch result {
            case .success(let creditInfo):
                self.handleSuccess(response: creditInfo)
                
            case .failure(let error):
                self.handleFailure(error: error)
            }
            ProgressHUD.dismiss()
        }
    }
    
    private func handleSuccess(response: Credit) {
        scoreData = response
        DispatchQueue.main.async {
            self.bindDataToController()
        }
    }
    
    private func handleFailure(error: ServiceError) {
        DispatchQueue.main.async {
            self.serviceFailur()
        }
        switch error {
        case .invalidEndpoint:
            ProgressHUD.show(errorMsgInvalidEndpoint, icon: .failed, interaction: true)
        case .invalidResponse, .decodeError:
            ProgressHUD.show(errorMsgInvalidResponse, icon: .failed, interaction: true)
        default:
            ProgressHUD.show(errorMsgUnknown, icon: .failed, interaction: true)
        }
    }
    
    // MARK: -  Getters
    
    func getCreditScore() -> Int {
        guard let creditReportInfo = scoreData?.creditReportInfo,
              let score = creditReportInfo.score else {
                  return 0
              }
        
        return score
    }
    
    func getMaxCreditScore() -> Int {
        guard let creditReportInfo = scoreData?.creditReportInfo,
              let maxScore = creditReportInfo.maxScoreValue else {
                  return 0
              }
        
        return maxScore
    }
    
    func getScorePercentage() -> CGFloat {
        let score = getCreditScore()
        let maxScore = getMaxCreditScore()
        
        return (maxScore <= 0) ? 0.0 : ((CGFloat(score) / CGFloat(maxScore)))
    }

}
