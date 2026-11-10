//
//  Learning_CH2App.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//

import SwiftUI
import SwiftData

@main
struct Learning_CH2App: App {
    
    @State private var viewModel = LearningViewModel()
    
    var body: some Scene {
        WindowGroup {
            selectionView()
                .environment(viewModel)
        }
       
    }
}
