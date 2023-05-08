//
//  WorkoutCell.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

struct WorkoutCellView: View {
    
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var workout: Workout
    
    var body: some View {
        
        CheckBoxView(workout: workout)
            .environmentObject(dataHolder)
        
        workoutInfo(workoutObj: workout)
            .padding(.horizontal)
        
    }
    
    private func workoutInfo(workoutObj: Workout) -> Text {
        return Text(
            (workoutObj.name ?? "Error of name")
            + ((workoutObj.exersices?.count ?? 0) > 0
               ? "\nExercises:\(String(describing: workoutObj.exersices!.count))"
               : "\nNo exercises")
            + (workoutObj.isComplete
               ? "\nCompleted: \(dateToStr(date: (workoutObj.completeDate ?? Date())))"
               : "")
        )
    }
    
    private func dateToStr(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
