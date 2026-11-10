//
//  MainView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import SwiftUI

struct MainView: View {
   @Environment(LearningViewModel.self) private var viewModel
    
    let calendar = Calendar.current

    var weekDates: [Date] {
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)

        let startOfWeek = calendar.date(
            byAdding: .day,
            value: -(weekday - 1),
            to: today
        )!
        
        var dates: [Date] = []
        for day in 0..<7 {
            if let date = calendar.date(
                byAdding: .day,
                value: day,
                to: startOfWeek
            ) {
                dates.append(date)
            }
        }

        return dates
    }
    
    
    var body: some View {

        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(alignment: .leading) {

                HStack {

                    Text("Activity")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Button {
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.tint(Color(.black.opacity(0.8))),
                                in: .capsule
                            ) }

                    Button {
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.tint(Color(.black.opacity(0.8))),
                                in: .capsule
                            )}
                }
                

                Text(Date(), format: .dateTime.weekday(.wide).day().month(.wide))
                    .font(.system(size: 17))
                    .foregroundStyle(.gray)
                
                HStack {
                    ForEach(weekDates, id: \.self) { date in

                        let isToday = calendar.isDateInToday(date)

                        VStack {

                            Text(date, format: .dateTime.weekday(.narrow))
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            
                            Text(date, format: .dateTime.day())
                                .font(.system(size: 22))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background {
                                    if isToday {
                                        Circle()
                                            .fill(Color("buttons"))
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 12)
                
                
                HStack (spacing:16){

                    VStack(spacing: 4)  {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(Color("buttons"))

                        var streakText: String {
                            let streak = viewModel.currentGoal?.streak ?? 0
                            return "\(streak) \(streak == 1 ? "day" : "days")"
                        }
                        Text(streakText)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)

                        Text("Learned")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                   // .frame(height: 102)
                    //.frame(width: 177)
                    .glassEffect(.regular.tint(Color(.black.opacity(0.8))), in: .rect(cornerRadius: 35))
                    
                    .shadow(color: .white, radius: 0.3)

                    
                    
                    
                    VStack(spacing: 4) {
                        Image(systemName: "snowflake")
                            .font(.system(size: 24))
                            .foregroundStyle(Color("freezeIcon"))

                        var freezeText: String {
                            let freeze = viewModel.currentGoal?.freezCount ?? 0
                            return "\(freeze) \(freeze == 1 ? "day" : "days")"
                        }
                        Text(freezeText)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        

                        Text("Freezed")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.frame(height: 102)
                    //.frame(width: 177)
                    .glassEffect(.regular.tint(Color(.black.opacity(0.8))), in: .rect(cornerRadius: 35))
                    .shadow(color: .white, radius: 0.3)
                    
                    
                }
                .padding()
                
                Spacer()
                
                
                VStack{
                    Button {
                
                    } label: {
                        Text("Log as Learned")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 292, height: 292)
                            .glassEffect(
                                .regular.tint(Color("buttons")),
                                in: .circle
                            )
                            .overlay {
                                Capsule()
                                    .stroke(
                                         Color.yellow.opacity(0.7)
                                    )
                            }
                         
                    }
                    .buttonStyle(.plain)
                    .padding()
                    
                    Spacer()
                    
                    VStack{
                        Button {
                            
                        } label: {
                            Text("Freeze for a day")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.white)
                                .frame(width: 292, height: 46)
                                .glassEffect(
                                    .regular.tint(Color("freezeIcon")),
                                    in: .capsule
                                )
                                .overlay {
                                    Capsule()
                                        .stroke(
                                             Color("freezeIcon").opacity(0.7)
                                        )
                                }
                             
                        }
                        .buttonStyle(.plain)
                        .padding()
                        
                        Text("0 out of 2 freezes used")}
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)
               
                
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
        .environment(LearningViewModel())
}
