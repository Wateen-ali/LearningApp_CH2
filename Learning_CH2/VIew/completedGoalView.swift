//
//  completedGoalView.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 01/06/1448 AH.
//

import Foundation
import SwiftUI

struct completedGoalView: View {
    var body: some View {

        ZStack{
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 64){
                VStack(spacing: 19){
                    Image(systemName: "hands.and.sparkles.fill")
                        .foregroundStyle(Color("buttons"))
                        .font(.system(size: 40))
                    VStack(spacing: 5){
                    Text("Well done!")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                    Text("Ready for your next goal?")
                        .foregroundStyle(.gray)
                        .font(.system(size: 16))
                }}
                NavigationLink {
                   updateGoalView()
                } label: {
                    Label("Set a goal",systemImage:"pencil.and.outline")
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
    completedGoalView()
}
