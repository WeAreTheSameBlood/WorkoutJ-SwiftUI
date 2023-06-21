//
//  ShareService.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

public func shareWorkoutLikeStr(workoutForShare: Workout) {
    
    let workoutModel: WorkoutShareModel = workoutForShare.toModel()
    let exercisesModel: [ExerciseShareModel] = (workoutForShare.exercises?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [Exercise]).map{$0.toModel()}
        
//        let data = try? JSONEncoder().encode(workoutForExport.toModel())
    
    let allWorkoutInStr: String = getWorkoutInfoToStr(workoutModel: workoutModel) + getExercisesInfoToStr(exercisesModel: exercisesModel)

    /*
        guard let exportUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("workout.json") else {
            print("Error getting export URL")
            return
        }

        try data!.write(to: exportUrl)
     */
    
        let activityVC = UIActivityViewController(activityItems: [allWorkoutInStr], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
}

private func getWorkoutInfoToStr(workoutModel: WorkoutShareModel) -> String {
    return """
            Workout: \(workoutModel.name) \(workoutModel.expectedDate != nil ? "\nOn date: \(dateToStr(date:(workoutModel.expectedDate!)))" : "") \((workoutModel.desc != "") ? "\nDesc: \(workoutModel.desc!)" : "")
            """
}

private func getExercisesInfoToStr(exercisesModel: [ExerciseShareModel]) -> String {
    var result: String = "\n"
    
    exercisesModel.forEach { exercise in
        result.append("""
                        \n\(exercise.name) \((exercise.desc! != "") ? "\nDesc: \(exercise.desc!)" : "")
                        \(getSetsInfoToStr(exerciseModel: exercise))\n-----------
                        """)
    }
    
    return result
}

private func getSetsInfoToStr(exerciseModel: ExerciseShareModel) -> String {
    
    guard (exerciseModel.sets.count > 1) else {return ""}
    
    var result: String = ""
    
    exerciseModel.sets.forEach { oneSet in
        result.append("\n\(oneSet.weight) kg X \(oneSet.reps)")
    }
    
    return result
}

