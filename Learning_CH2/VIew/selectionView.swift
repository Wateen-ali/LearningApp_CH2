//
//  selectionView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import SwiftUI
import SwiftData

struct selectionView: View {
    // connect us with ViewModle functions 
    @Environment(LearningViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack{
       
              
        VStack {
            Image(systemName: "flame.fill")
                .font(.system(size: 36))
                .foregroundStyle(Color("buttons"))
                .padding(60)
 
            VStack{
                Text("Hello **Learner**")
                .font(.system(size: 34))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
             
                Text("This app will help you learn everyday!")
                .font(.system(size: 17))
                .foregroundStyle(.primary)
                .opacity(0.4)
                .frame(maxWidth: .infinity, alignment: .leading)
                  }
            
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.top)
                   .padding(.bottom,37)
               
            Group{
                Text("I want to learn")
                    .font(.system(size: 16))
                    .foregroundStyle(.primary)
                
                TextField("",text: $viewModel.goalName, prompt: Text("Swift").foregroundStyle(.gray.opacity(0.6)))
                    .padding(.top)
                    .foregroundStyle(.white)
                    .autocorrectionDisabled()
                
                Divider()
                    .background(Color.gray.opacity(0.9))
                    .padding(.bottom)
               
                Text("I want to learn it in a")
                    .foregroundStyle(.primary)
                    .font(.system(size: 16))
                
                
                HStack {
                    ForEach( [goalDuration.week, .month, .year], id: \.self) { duration in

                        Button {
                            viewModel.selectedDuration = duration
                               } label: {
                            //text color
                                     Text(duration.rawValue.capitalized)
                                       .font(.system(size: 18))
                                       .foregroundStyle(viewModel.selectedDuration == duration
                                            ? Color.primary
                                            : Color.primary.opacity(0.4))
                                .padding(.horizontal, 22)
                                .padding(.vertical, 14)
                                   
                            //button color
                                .glassEffect(.regular.tint(viewModel.selectedDuration == duration
                                        ? Color("buttons")
                                        : Color.primary.opacity(0.001)),
                                    in: .capsule)
                                   
                            // a border
                                .overlay { Capsule()
                                        .stroke(
                                            viewModel.selectedDuration == duration
                                            ? Color.yellow.opacity(0.7)
                                            : Color.primary.opacity(0.0))
                                         }}}
                       }//end HStack
                
                 }//end Group
                 .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
 
            VStack(spacing:12){
                Button {
                    //calling the function from view model
                    viewModel.saveLearningGoal(name: viewModel.goalName,duration: viewModel.selectedDuration)
                       } label: {
                             Text("Start Learning")
                             .font(.system(size: 20, weight: .semibold))
                             .foregroundStyle(Color.primary)
                             .padding(.horizontal, 25)
                             .padding(.vertical, 14)
                             .glassEffect(.regular.tint(Color("buttons")),in: .capsule)
                                }
                       .overlay {Capsule().stroke( Color.yellow.opacity(0.7))}

                Text("You can edit your desire later")
                    .foregroundStyle(.gray)
                    .font(.system(size: 12))
            }
            .frame(maxWidth: .infinity)
   
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }}}

#Preview {
    selectionView()
        .environment(LearningViewModel())
        .preferredColorScheme(.light)
}

#Preview {
    selectionView()
        .environment(LearningViewModel())
        .preferredColorScheme(.dark)

}
