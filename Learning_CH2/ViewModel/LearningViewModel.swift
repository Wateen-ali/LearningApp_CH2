//
//  LearningViewModel.swift
//  Learning_CH2
//
//  Created by wateen Alrumayh on 29/05/1448 AH.
//
import Foundation
import Observation
// to let other UI know the changes of value
@Observable
class LearningViewModel {

    var goalName = ""
    //set a defulte duration to week
    var selectedDuration: goalDuration = .week
    var currentGoal: UserGoal?
    //to deside if the app check if there is goals saved --> heloing deside what screen to pick 
    var hasLoadedGoal = false
    var activities: [dailyActivity] = []

    // =================load the saved goal=================
    
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

    // =================save the goal=================
    
    func saveGoal() {
        guard let currentGoal = currentGoal else { return }

        do {
            let data = try JSONEncoder().encode(currentGoal)
            UserDefaults.standard.set(data, forKey: "savedGoal")
        } catch {
            print("Error saving goal: \(error)")
        }
    }

    // =================load the Activities=================
    
    func loadActivities() {
        if let data = UserDefaults.standard.data(forKey: "savedActivities") {
            do {
                activities = try JSONDecoder().decode(
                    [dailyActivity].self,
                    from: data
                )
            } catch {
                print("Error loading activities: \(error)") }} }
    
    // =================save the activities=================
    
    func saveActivities() {
        do {
            let data = try JSONEncoder().encode(activities)
            UserDefaults.standard.set(data, forKey: "savedActivities")
        } catch {
            print("Error saving activities: \(error)")} }
    
    // =================get todays statuse=================
    
    func todayStatus() -> dailyStatus? {
        guard let goal = currentGoal else { return nil }

        return activities.first {
            //we check if the activity was today and check if its before or in the current goal in case the user edit the goal at same day while he was logged himself as learnd or freeze
            Calendar.current.isDateInToday($0.date) && $0.date >= goal.startDate
        }?.status
    }
    
   //=====================updating the status of today===============================
    
    func updateToday(status: dailyStatus) {
        guard var goal = currentGoal else { return }
        //get the last status loged
        let previousStatus = todayStatus()

        // if the same button is clicked again undo the activity
        if previousStatus == status {

            if status == .learned {goal.streak = max(0, goal.streak - 1)}
            else {goal.freezCount = max(0, goal.freezCount - 1)}

            activities.removeAll { Calendar.current.isDateInToday($0.date)}
            currentGoal = goal
            saveGoal()
            saveActivities()
            return
        }

        // Check freeze limit before changing anything
        if status == .freeze && goal.freezCount >= goal.duration.freezeLimit {return}

        // Remove the previous activity's count
        if previousStatus == .learned { goal.streak = max(0, goal.streak - 1)}
        else if previousStatus == .freeze {goal.freezCount = max(0, goal.freezCount - 1)}

        // Add the new activity's count
        if status == .learned { goal.streak += 1}
        else {goal.freezCount += 1}

        // Keep only one activity per day
        activities.removeAll { Calendar.current.isDateInToday($0.date)}
        activities.append(dailyActivity(date: Date(), status: status))

        currentGoal = goal
        saveGoal()
        saveActivities()
    }
    
    //======================get the status of specific date==============================
    
    func status(for date: Date) -> dailyStatus? {
        // If it's today, use the current goal's activity
        if Calendar.current.isDateInToday(date) { return todayStatus()}
       // Keep the activity history for previous days
        return activities.first { Calendar.current.isDate($0.date, inSameDayAs: date)}?.status
    }
    
    //======================start a goal==============================
    
    // Start a new learning goal
    func saveLearningGoal(name: String, duration: goalDuration, isEditing: Bool = false) {

        if !isEditing && currentGoal != nil {print("You already have a learning goal!")
    return }

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
        print("Goal saved successfully!")
    }

    //====================================================
    
    func checkStreakExpiration() {
        guard var goal = currentGoal else { return }

        let lastActivity = activities
        //ignore activities from prevoius goal
            .filter { $0.date >= goal.startDate }
        //get the lateset activity 
            .max { $0.date < $1.date }

        guard let lastActivity else { return }

        let hoursPassed = Date().timeIntervalSince(lastActivity.date) / 3600

        if hoursPassed >= 32 {
//        let minutesPassed = Date().timeIntervalSince(lastActivity.date) / 60
//
//        if minutesPassed >= 2 {
            goal.streak = 0
            currentGoal = goal
            saveGoal()
        }
    }
    
    //====================================================
    
    func goalResult() -> GoalResult {
        guard let goal = currentGoal else { return .active }
        let calendar = Calendar.current

        // The goal is still running
        if Date() < goal.endDate {
            return .active}
        
        // caculate the total numbers of days
        let totalDays = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: goal.startDate),
            to: calendar.startOfDay(for: goal.endDate)
        ).day ?? 0
        
        //calculate the dayes that has activity
        let recordedDays = Set(
            activities
                .filter {$0.date >= goal.startDate && $0.date < goal.endDate}
                .map { calendar.startOfDay(for: $0.date)}).count

        let missedDays = max(0, totalDays - recordedDays)
        if missedDays <= goal.duration.missedDaysLimit { return .completed}
        else {return .failed}
    }
    
}
