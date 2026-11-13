//
//  CalendarViewModel.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 03/06/1448 AH.
//

import Foundation
import SwiftUI
import Observation

@Observable
class CalendarViewModel {
    
    let calendar = Calendar.current

    var weekDates: [Date] {
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date( byAdding: .day, value: -(weekday - 1), to: today)!
        var dates: [Date] = []
        for day in 0..<7 {if let date = calendar.date( byAdding: .day, value: day, to: startOfWeek) {dates.append(date)} }

        return dates}

    func circleColor(for date: Date, status: dailyStatus?) -> Color {

        if status == .freeze {
            return Color("freezeIcon").opacity(0.2)
        } else if status == .learned {
            return Color("buttons").opacity(0.3)
        } else if Calendar.current.isDateInToday(date) {
            return Color("buttons")
        } else {
            return .clear
        }
    }

    func textColor(for status: dailyStatus?) -> Color {

        if status == .learned {
            return Color("buttons")
        } else if status == .freeze {
            return Color("freezeIcon")
        } else {
            return .white
        }
    }
}
