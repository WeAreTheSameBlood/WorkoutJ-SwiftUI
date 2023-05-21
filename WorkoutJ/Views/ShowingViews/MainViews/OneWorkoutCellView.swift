//
//  WorkoutCell.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

struct OneWorkoutCellView: View {
    
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var workout: Workout
    
    var body: some View {
        HStack {
            
            CheckBoxView(workout: workout)
                .environmentObject(dataHolder)
            
            OneWorkoutInfoView(workout: workout)
            
//            VStack(spacing: 0) {
//                HStack {
//                    Text("\(workout.name!)").opacity(1)
//                    Spacer()
//                }
//                HStack {
//                    (workout.exersices!.count > 0
//                     ? (Text("Exercises: \(String(describing: workout.exersices!.count))").opacity(1))
//                     : (Text("No exercises").opacity(0.5)))
//                    Spacer()
//                }
//                HStack {
//                    workout.isComplete ? Text("Completed: \(dateToStr(date: (workout.completeDate ?? Date())))").opacity(1) : nil
//                    Spacer()
//                }
//
//            }
//            .listStyle(InsetListStyle())

        }
    }
    
//    private func workoutInfo(workoutObj: Workout) -> Text {
//        return Text(
//            (workoutObj.name!)
//            + ((workoutObj.exersices?.count ?? 0) > 0
//               ? "\nExercises:\(String(describing: workoutObj.exersices!.count))"
//               : "\nNo exercises")
//            + (workoutObj.isComplete
//               ? "\nCompleted: \(dateToStr(date: (workoutObj.completeDate ?? Date())))"
//               : "")
//        )
//    }
    
//    private func dateToStr(date: Date) -> String{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        return formatter.string(from: date)
//    }
}
