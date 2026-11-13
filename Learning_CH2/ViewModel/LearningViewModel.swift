//
//  LearningViewModel.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//
import Foundation
import Observation

@Observable
class LearningViewModel {

    var goalName = ""
    var selectedDuration: goalDuration = .week
    var currentGoal: UserGoal?
    var hasLoadedGoal = false
    var activities: [dailyActivity] = []

    // Load the saved goal
    func loadGoal() {
        if let data = UserDefaults.standard.data(forKey: "savedGoal") {
            do {
                currentGoal = try JSONDecoder().decode(UserGoal.self, from: data)
            } catch {
                print("Error loading goal: \(error)")
            }
        }

        hasLoadedGoal = true
    }

    // Save the goal
    func saveGoal() {
        guard let currentGoal = currentGoal else { return }

        do {
            let data = try JSONEncoder().encode(currentGoal)
            UserDefaults.standard.set(data, forKey: "savedGoal")
        } catch {
            print("Error saving goal: \(error)")
        }
    }

    
    func loadActivities() {
        if let data = UserDefaults.standard.data(forKey: "savedActivities") {
            do {
                activities = try JSONDecoder().decode(
                    [dailyActivity].self,
                    from: data
                )
            } catch {
                print("Error loading activities: \(error)")
            }
        }
    }
    
    func saveActivities() {
        do {
            let data = try JSONEncoder().encode(activities)
            UserDefaults.standard.set(data, forKey: "savedActivities")
        } catch {
            print("Error saving activities: \(error)")
        }
    }
    
    func todayStatus() -> dailyStatus? {
        activities.first {
            Calendar.current.isDateInToday($0.date)
        }?.status
    }
    
    func updateToday(status: dailyStatus) {
        guard var goal = currentGoal else { return }

        let previousStatus = todayStatus()

        // Don't record the same action twice
        if previousStatus == status {
            return
        }

        // Remove the previous action's count
        if previousStatus == .learned {
            goal.streak = max(0, goal.streak - 1)
        } else if previousStatus == .freeze {
            goal.freezCount = max(0, goal.freezCount - 1)
        }

        // Add the new action's count
        if status == .learned {
            goal.streak += 1
        } else {
            if goal.freezCount >= goal.duration.freezeLimit {
                return
            }
            goal.freezCount += 1
        }

        // Keep only one activity per calendar day
        activities.removeAll {
            Calendar.current.isDateInToday($0.date)
        }

        activities.append(
            dailyActivity(date: Date(), status: status)
        )

        currentGoal = goal
        saveGoal()
        saveActivities()
    }
    
    func status(for date: Date) -> dailyStatus? {
        activities.first {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }?.status
    }
    
    
    
    // Start a new learning goal
    func startLearning() {
        loadGoal()

        guard currentGoal == nil else {
            print("You already have a learning goal!")
            return
        }

        let startDate = Date()
        let endDate: Date

        switch selectedDuration {
        case .week:
            endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        case .month:
            endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        case .year:
            endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)!
        }

        let goal = UserGoal(
            goalName: goalName,
            duration: selectedDuration,
            freezCount: 0,
            streak: 0,
            startDate: startDate,
            endDate: endDate
        )

        currentGoal = goal
        saveGoal()

        print("Goal saved successfully!")
    }
    
    func replaceGoal(name: String, duration: goalDuration) {
        let startDate = Date()
        let endDate: Date

        switch duration {
        case .week:
            endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        case .month:
            endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        case .year:
            endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)!
        }
        
        currentGoal = UserGoal(
            goalName: name,
            duration: duration,
            freezCount: 0,
            streak: 0,
            startDate: startDate,
            endDate: endDate
        )

        saveGoal()
    }
}
