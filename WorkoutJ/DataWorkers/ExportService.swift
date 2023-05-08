//
//  ExportService.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

public func csvExportWorkout(workoutForExport: Workout) {
        
//        let data = try? JSONEncoder().encode(workoutForExport.toModel())
        let workoutToStr = toString(workoutForExport: workoutForExport)
        

//        guard let exportUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("workout.json") else {
//            print("Error getting export URL")
//            return
//        }
//
//        try data!.write(to: exportUrl)
        
        let activityVC = UIActivityViewController(activityItems: [workoutToStr], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
}

private func toString(workoutForExport: Workout) -> String {
    let workoutModelStr = workoutForExport.toModel()
    let exersicesStr = workoutForExport.exersices?.allObjects as! [Exercise]
    
    var exersisecInfo = ""
    
    for ex in exersicesStr {
        exersisecInfo.append("\n\t\(ex.toModel().name)")
    }
    return "Workout: \(workoutModelStr.name) \nDesc: \(workoutModelStr.desc ?? "")\nExercises: \(exersisecInfo)"
}


