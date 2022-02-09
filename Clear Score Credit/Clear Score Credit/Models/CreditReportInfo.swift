//
//  CreditReportInfo.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

public struct CreditReportInfo: Codable {
    
    public let score: Int?
    public let scoreBand: Int?
    public let status: String?
    public let maxScoreValue: Int?
    public let minScoreValue: Int?
    
}

extension CreditReportInfo: Equatable {
    
    public static func ==(lhs: CreditReportInfo, rhs: CreditReportInfo) -> Bool {
        return lhs.score == rhs.score &&
        lhs.scoreBand == rhs.scoreBand &&
        lhs.status == rhs.status &&
        lhs.maxScoreValue == rhs.maxScoreValue &&
        lhs.minScoreValue == rhs.minScoreValue
    }
    
}
