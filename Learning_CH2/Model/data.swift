//
//  data.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import Foundation
import SwiftData


// for data that has listed values
enum goalDuration: String, Codable {
    case week
    case month
    case year

    var freezeLimit: Int {
        switch self {
        case .week: return 2
        case .month: return 8
        case .year: return 96
        }
        
    }
    
    var missedDaysLimit: Int {
        switch self {
        case .week: return 2
        case .month: return 10
        case .year: return 120
        }
    }
}

enum dailyStatus: String, Codable {
    case learned
    case freeze
}

enum GoalResult {
    case active
    case completed
    case failed
}


// models for data structure
struct dailyActivity: Codable {
    var date: Date
    var status: dailyStatus
}


struct UserGoal: Codable{
    var goalName: String
    var duration: goalDuration
    var freezCount: Int
    var streak: Int
    var startDate: Date
    var endDate: Date }
