//
//  failedGoalView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 01/06/1448 AH.
//



import Foundation
import SwiftUI

struct failedGoalView: View {
    var body: some View {
  
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 64){
                VStack(spacing: 19){
                    Image(systemName: "xmark.seal.fill")
                        .foregroundStyle(Color("buttons"))
                        .font(.system(size: 40))
                    VStack(spacing: 5){
                    Text("You didn't reach your goal this time.")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .bold))
                    Text("Want to set another goal?")
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                }}
                NavigationLink {
                  updateGoalView()
                } label: {
                    
                    Label("Set a gaol",systemImage:"pencil.and.outline")
                    
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 140, height: 50)
                        .glassEffect(
                            .regular.tint(Color("buttons")),
                            in: .capsule
                        )
                    
                    
                }
                
                
                
                
            }
            .environment(\.colorScheme, .dark)
            
        }
    }
}

#Preview {
    failedGoalView()
}
