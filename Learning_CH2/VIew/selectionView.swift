//
//  selectionView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import SwiftUI
import SwiftData

struct selectionView: View {
    // connect us with the data
 
    // connect us with ViewModle functions 
    @Environment(LearningViewModel.self) private var viewModel
    var body: some View {
        
        
        @Bindable var viewModel = viewModel
        
        ZStack{
           Color(.black)
                .ignoresSafeArea()
              
        VStack {
            
            Image(systemName: "flame.fill")
                .font(.system(size: 36))
                .foregroundStyle(Color("buttons"))
                .padding(60)
                
           // Spacer()
            
            VStack{
                Text("Hello **Learner**")
                    .font(.system(size: 34))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
             
            Text("This app will help you learn everyday!")
                .font(.system(size: 17))
                .foregroundStyle(.white)
                .opacity(0.4)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.bottom,37)
               
            Group{
                Text("I want to learn")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                
                TextField("",  text: $viewModel.goalName, prompt: Text("Swift").foregroundStyle(.gray))
                    .padding(.top)
                   
                    .foregroundStyle(.white)
                    .autocorrectionDisabled()
                
                Divider()
                    .background(Color.gray.opacity(0.9))
                    .padding(.bottom)
                
                
              
                Text("I want to learn it in a")
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                
                
                HStack {
                    ForEach(
                        [goalDuration.week, .month, .year],
                        id: \.self
                    ) { duration in

                        Button {
                            viewModel.selectedDuration = duration
                        } label: {
                            Text(duration.rawValue.capitalized)
                                .font(.system(size: 18))
                                .foregroundStyle(
                                    viewModel.selectedDuration == duration
                                    ? .white
                                    : .gray.opacity(0.6)
                                )
                                .padding(.horizontal, 22)
                                .padding(.vertical, 14)
                                .glassEffect(
                                    .regular.tint(
                                        viewModel.selectedDuration == duration
                                        ? Color("buttons")
                                        : .black.opacity(0.8)
                                    ),
                                    in: .capsule
                                )
                            // a border
                                .overlay {
                                    Capsule()
                                        .stroke(
                                            viewModel.selectedDuration == duration
                                            ? Color.yellow.opacity(0.7)
                                            : Color.white.opacity(0.0)
                                        )
                                }
                        }
                       
                    }
                }//end HStack
                
            }//end Group
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Spacer()
            
            
            VStack (spacing:12){
                Button {
                    viewModel.startLearning()
                } label: {
                    Text("Start Learning")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 14)
                        .glassEffect(
                            .regular.tint(Color("buttons")),
                            in: .capsule
                        )
                }
                .overlay {
                    Capsule()
                        .stroke(
                             Color.yellow.opacity(0.7)
                        )
                }
             

                Text("You can edit your desire later")
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 12))
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    }
    
  
}

#Preview {
    selectionView()
        .environment(LearningViewModel())
//        .modelContainer(
//                   for: [UserGoal.self, dailyActivity.self],
//                   inMemory: true
//               )
}

