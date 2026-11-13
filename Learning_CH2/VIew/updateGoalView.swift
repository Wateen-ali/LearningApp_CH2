//
//  updateGoalSwift.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 01/06/1448 AH.
//

import Foundation
import SwiftUI

struct updateGoalView: View {
    
    @Environment(LearningViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var editedGoalName = ""
    @State private var editedDuration: goalDuration = .week
    @State private var showConfirmation = false
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack{
           Color(.black)
                .ignoresSafeArea()
              
        VStack {
            Group{
                Text("I want to learn")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                
                TextField("",  text: $editedGoalName, prompt: Text("Swift").foregroundStyle(.gray))
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
                    ForEach([goalDuration.week, .month, .year],id: \.self) { duration in
                        Button {
                            editedDuration = duration
                        } label: {
                            Text(duration.rawValue.capitalized)
                                .font(.system(size: 18))
                                .foregroundStyle(editedDuration == duration
                                    ? .white
                                    : .gray.opacity(0.6))
                                .padding(.horizontal, 22)
                                .padding(.vertical, 14)
                                .glassEffect(.regular.tint(editedDuration == duration
                                        ? Color("buttons")
                                        : .white.opacity(0.001)),
                                    in: .capsule)
                            // a border
                                .overlay {Capsule()
                                        .stroke(
                                            editedDuration == duration
                                            ? Color.yellow.opacity(0.7)
                                            : Color.white.opacity(0.0)
                                        )}}}
                }//end HStack
                }//end Group
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.leading,10)
        .padding(.top)
        .frame( maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        .overlay {
            if showConfirmation {
                ZStack {
                    Color.black.opacity(0.7)
                        .ignoresSafeArea()

                    VStack(alignment: .leading, spacing: 20) {
                        VStack (alignment: .leading, spacing: 12){
                            Text("Update goal")
                                .font(.system(size: 20,weight: .semibold))
                            
                            Text("If you update now, your streak will start over.")
                                .font(.system(size: 19))
                                .foregroundStyle(.gray)}

                        HStack {
                            Button("Dismiss") {
                                showConfirmation = false
                            }
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.gray.opacity(0.3), in: Capsule())

                            Button("Update") {
                                viewModel.replaceGoal(name: editedGoalName,duration: editedDuration)
                                dismiss()
                            }
                            .font(.system(size: 20,weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("buttons"), in: Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.top,7)
                    .glassEffect(.regular.tint( .black.opacity(0.3)),
                                 in: .rect(cornerRadius: 30))
                    .overlay{RoundedRectangle(cornerRadius: 30)
                            .stroke(.gray.opacity(0.2))}
                    .padding(35)
                    
                }
            }
        }
        .environment(\.colorScheme, .dark)
    }


        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Learning Goal")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showConfirmation = true
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(Color("buttons"), in: Circle())
                        .overlay {
                            Capsule()
                                .stroke(
                                    Color(.yellow).opacity(0.7))}}
                .buttonStyle(.plain)
                .glassEffect(.identity)
            }
            .sharedBackgroundVisibility(.hidden)
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                   dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .glassEffect(.regular.tint(.black.opacity(0.8)),
                            in: .capsule)
                        .overlay { Capsule()
                                .stroke(Color(.white).opacity(0.1))
                        }}
                .buttonStyle(.plain)
                .glassEffect(.identity)
            }
            .sharedBackgroundVisibility(.hidden)
        }
      
    }
}

#Preview {
    NavigationStack {
          updateGoalView()
              .environment(LearningViewModel())
      }
}
