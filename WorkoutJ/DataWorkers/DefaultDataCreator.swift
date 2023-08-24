//
//  SingletonDataCreator.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 24.08.2023.
//

import SwiftUI
import CoreData

public class DefaultDataCreator {
    
    private init() {}
    
    public static func CreateDefaultCategories(context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<ExerciseCategory> = ExerciseCategory.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            guard count == 0 else {
                return
            }
            
            let _: [ExerciseCategory] = [
                    ExerciseCategory(name: "Basic", imageName: "figure.strengthtraining.traditional", schematicColor: .blue),
                    ExerciseCategory(name: "Cardio", imageName: "figure.indoor.cycle", schematicColor: .mint),
                    ExerciseCategory(name: "Warm-up", imageName: "figure.cooldown", schematicColor: .orange),
                    ExerciseCategory(name: "Stretching", imageName: "figure.flexibility", schematicColor: .red),
                    ExerciseCategory(name: "Hang-up", imageName: "figure.rolling", schematicColor: .brown),
                    ]
            
            try? context.save()
            
        } catch {
            fatalError("Failed to fetch categories: \(error)")
        }
    }
    
}
