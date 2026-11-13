//
//  MainView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import SwiftUI

struct MainView: View {
    
       // connect us with ViewModle functions 
   @Environment(LearningViewModel.self) private var viewModel
   @State private var calendarViewModel = CalendarViewModel()


    
    var body: some View {
        NavigationStack{
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                //top section
                HStack {
                    Text("Activity")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    NavigationLink {
                        calendarView()
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.tint(Color(.black.opacity(0.8))),
                                         in: .capsule
                            ) }
                    
                    NavigationLink {
                        updateGoalView()
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.tint(Color(.black.opacity(0.8))),
                                         in: .capsule
                            )}
                }
                
                // displaying todays date
                Text(Date(), format: .dateTime.weekday(.wide).day().month(.wide))
                    .font(.system(size: 17))
                    .foregroundStyle(.gray)
                // week calendar
                HStack {
                    ForEach(calendarViewModel.weekDates, id: \.self) { date in
                      
                        let status = viewModel.status(for: date)
                        
                        VStack {
                            // day name : SUN, Mon etc..
                            Text(date, format: .dateTime.weekday(.narrow))
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            // the date
                            Text(date, format: .dateTime.day())
                                .font(.system(size: 22,weight: .semibold))
                                .foregroundStyle( calendarViewModel.textColor(for: status) )
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                            //calling the color function
                                .background(
                                    Circle()
                                        .fill(calendarViewModel.circleColor(for: date, status: status))
                                        
                                )
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 12)
                
                // steak / freez card
                HStack (spacing:16){
                    VStack(spacing: 4)  {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(Color("buttons"))
                        // getting the streak number from view model
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
                     .frame(height: 102)
                    .frame(width: 177)
                    .glassEffect(.regular.tint(Color(.white.opacity(0.001))), in: .rect(cornerRadius: 35))
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
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 102)
                    .frame(width: 177)
                    .glassEffect(.regular.tint(Color(.white.opacity(0.001))), in: .rect(cornerRadius: 35))
                    .shadow(color: .white, radius: 0.3)
                    
                    
                }
                .padding()
                // bottom part
                Spacer()
                if viewModel.goalResult() == .completed {
                    completedGoalView()

                } else if viewModel.goalResult() == .failed {
                    failedGoalView()

                } else {
                   
                    
                    
                    VStack{
                        Button {
                            viewModel.updateToday(status: .learned)
                        } label: {
                            
                            Text("Log as Learned")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle( viewModel.todayStatus() == .learned ?
                                                  
                                    .white.opacity(0.5)
                                    :
                                    .white)
                                .frame(width: 292, height: 292)
                                .glassEffect(
                                    .regular.tint(
                                        viewModel.todayStatus() == .learned
                                        ? Color.white.opacity(0.001)
                                        : Color("buttons")
                                    ),
                                    in: .circle
                                )
                                .overlay {
                                    Capsule()
                                        .stroke(
                                            viewModel.todayStatus() == .learned ?
                                            Color(.black)
                                              
                                            :
                                            Color.yellow.opacity(0.7)
                                        )
                                }
                            
                            
                          
                        }
                     
                        .buttonStyle(.plain)
                        .padding()
                        
                        Spacer()
                        
                        VStack{
                            Button {
                                viewModel.updateToday(status: .freeze)
                            } label: {
                                
                                
                                Text("Freeze for a day")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(
                                        viewModel.todayStatus() == .freeze ?
                                        
                                        .white.opacity(0.5)
                                        :
                                        .white
                                    )
                                    .frame(width: 292, height: 46)
                                    .glassEffect(
                                        .regular.tint(
                                            viewModel.todayStatus() == .freeze
                                            ? Color.white.opacity(0.001)
                                            : Color("freezeIcon")
                                        ),
                                        in: .capsule
                                    )
                                    .overlay {
                                        Capsule()
                                            .stroke(
                                                viewModel.todayStatus() == .freeze ?
                                                Color(.black)
                                                  
                                                :
                                                    Color("freezeIcon").opacity(0.7)
                                            )
                                    }

                            }
                            // if clicked or reach the limit it will be disabled 
                            .disabled(
                                viewModel.todayStatus() != .freeze &&
                                (viewModel.currentGoal?.freezCount ?? 0) >=
                                (viewModel.currentGoal?.duration.freezeLimit ?? 0)
                            )
                            .buttonStyle(.plain)
                            .padding()
                            
                            Text("\(viewModel.currentGoal?.freezCount ?? 0) out of \(viewModel.currentGoal?.duration.freezeLimit ?? 0) freezes used")
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }
            .padding()
            .environment(\.colorScheme, .dark)
        }}
        .task {
            viewModel.loadActivities()
            viewModel.checkStreakExpiration()
        }
    }
}

#Preview {
 
        MainView()
        .environment(LearningViewModel())
}
