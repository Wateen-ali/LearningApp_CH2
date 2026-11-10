//
//  Learning_CH2App.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//
import SwiftUI

@main
struct Learning_CH2App: App {

    @State private var viewModel = LearningViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if !viewModel.hasLoadedGoal {
                    ProgressView()
                } else if viewModel.currentGoal == nil {
                    selectionView()
                } else {
                    MainView()
                }
            }
            .environment(viewModel)
            .task {
                if !viewModel.hasLoadedGoal {
                    viewModel.loadActivities()
                    viewModel.loadGoal()
                }
            }
        }
    }
}
