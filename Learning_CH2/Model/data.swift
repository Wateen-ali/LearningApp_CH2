//
//  data.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import Foundation
import SwiftData
/*
 goal name
 goal duration
 freez
 streak
 start date
 end date

 */

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
}

enum dailyStatus: String, Codable {
    case learned
    case freeze
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
    var endDate: Date
   
  
    
  
    }




