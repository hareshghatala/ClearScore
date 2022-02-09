//
//  Credit.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

public struct Credit: Codable {
    
    public let accountIDVStatus: String?
    public let creditReportInfo: CreditReportInfo?
    public let dashboardStatus: String?
    public let personaType: String?
    
}

extension Credit: Equatable {
    
    public static func ==(lhs: Credit, rhs: Credit) -> Bool {
        return lhs.accountIDVStatus == rhs.accountIDVStatus &&
        lhs.creditReportInfo == rhs.creditReportInfo &&
        lhs.dashboardStatus == rhs.dashboardStatus &&
        lhs.personaType == rhs.personaType
    }
    
}
