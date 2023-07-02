//
//  WorkoutJApp.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI
import CoreData

@main
struct WorkoutJApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        let context = persistenceController.container.viewContext
        let dataHolder = DataHolder(context)
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
                .environmentObject(dataHolder)
                .onAppear {
                    seedCategoriesIfNeeded(context: context)
                }
        }
    }
    
    private func seedCategoriesIfNeeded(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<ExerciseCategory> = ExerciseCategory.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            guard count == 0 else {
                return
            }
            
            let BASIC_CATEGORIES: [ExerciseCategory] = [
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
