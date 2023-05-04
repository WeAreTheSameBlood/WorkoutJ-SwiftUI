//
//  Persistence.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for num in 1...4 {
            let newWorkout = Workout(context: viewContext)
            
            let ex1 = Exercise(context: viewContext)
            let ex2 = Exercise(context: viewContext)
            let ex3 = Exercise(context: viewContext)
            
            newWorkout.serial = Int32(num)
            newWorkout.name = "Name for \(num) workout"
            newWorkout.isComplete = .random()
            newWorkout.createdDate = Date()
            newWorkout.exersices = []
            
//            for _ in 1...4 {
//                let ex = Exercise(context: viewContext)
//                ex.name = "Exercice name for \(num) workout"
//                ex.reps = .random(in: Range(uncheckedBounds: (1, 20)))
//                ex.weight = .random(in: ClosedRange(uncheckedBounds: (5.0, 60.0)))
//
//            }
            
            ex1.name = "Exercice name for \(num) workout"
            ex2.name = "Exercice name for \(num) workout"
            ex3.name = "Exercice name for \(num) workout"

            ex1.reps = .random(in: Range(uncheckedBounds: (1, 20)))
            ex2.reps = .random(in: Range(uncheckedBounds: (1, 20)))
            ex3.reps = .random(in: Range(uncheckedBounds: (1, 20)))

            ex1.weight = .random(in: ClosedRange(uncheckedBounds: (5.0, 60.0)))
            ex2.weight = .random(in: ClosedRange(uncheckedBounds: (5.0, 60.0)))
            ex3.weight = .random(in: ClosedRange(uncheckedBounds: (5.0, 60.0)))

            newWorkout.exersices = [ex1, ex2, ex3]
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "WorkoutJ")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
