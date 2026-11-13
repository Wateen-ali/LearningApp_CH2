//
//  calendarView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 30/05/1448 AH.
//

import Foundation
import SwiftUI
import HorizonCalendar


struct calendarView: View {
    
       // connect us with ViewModle functions
    @Environment(LearningViewModel.self) private var viewModel
    @State private var calendarViewModel = CalendarViewModel()

    var currentYear: Int = Calendar.current.component(.year, from: Date())
    let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    var startDate: Date {Calendar.current.date( from: DateComponents( year: currentYear,month: 1,day: 1))!}
    var endDate: Date { Calendar.current.date(from: DateComponents(year: currentYear,month: 12,day: 31 ) )!}
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

                CalendarViewRepresentable(
                    calendar: Calendar.current,
                    visibleDateRange: startDate...endDate,
                    monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()),
                    dataDependency: nil)
            
                .dayOfWeekHeaders { month, weekdayIndex in
                    Text("\(weekdays[weekdayIndex])")
                        .font(.system(size: 16,weight: .bold))
                        .foregroundStyle(.gray)}
            
                .monthHeaders { month in
                    VStack(alignment: .leading) {
                        Divider()
                            .overlay(Color.gray.opacity(0.9))

                           Text("\(Calendar.current.monthSymbols[month.month - 1]) \(String(month.year))")
                               .font(.headline)
                               .fontWeight(.semibold)
                               .foregroundStyle(.white)
                       }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.leading, 11) }
            
                .days { day in
                    
                    let date = Calendar.current.date(
                            from: DateComponents(
                                year: day.month.year,
                                month: day.month.month,
                                day: day.day))
                    
                    let status = date.flatMap {viewModel.status(for:$0) }
                    let isToday = date.map {Calendar.current.isDateInToday($0) } ?? false
                    
                    Text("\(day.day)")
                        .font(.system(size: 20,weight: .semibold))
                        .foregroundStyle(calendarViewModel.textColor(for: status))
                        .frame(width: 40, height: 40)
                        .background {Circle()
                                .fill(
                                  date.map {calendarViewModel.circleColor(for: $0,status: status)} ?? .clear
                                              )}
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .environment(\.colorScheme, .dark)
       }
        .navigationTitle("Activities")
    }
}

#Preview {
    calendarView()
        .environment(LearningViewModel())
}



