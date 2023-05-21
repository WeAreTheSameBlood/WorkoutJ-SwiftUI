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
            
            
            newWorkout.serial = Int32(num-1)
            newWorkout.name = "Name for \(num) workout"
            newWorkout.desc = .random() ? "Basic desc for this workout" : ""
            newWorkout.isComplete = .random()
            if newWorkout.isComplete == true {
                newWorkout.completeDate = Date()
            }
            newWorkout.createdDate = Date()
            newWorkout.exersices = []
            
            ex1.name = "Exercice name for \(num) workout"
            ex2.name = "Exercice name for \(num) workout"
            ex3.name = "Exercice name for \(num) workout"
            
            ex1.desc = ""
            ex2.desc = ""
            ex3.desc = ""
            
            ex1.serial = 0
            ex2.serial = 1
            ex3.serial = 2

            newWorkout.exersices = [ex1, ex2, ex3]
            
            for ex in (newWorkout.exersices?.allObjects as! [Exercise]) {
                var setsArr : [SetOfExercise] = []
                
                for set in 1...4 {
                    let exSet = SetOfExercise(context: viewContext)
                    exSet.serial = Int32(set-1)
                    exSet.reps = .random(in: Range(uncheckedBounds: (1, 12)))
                    exSet.weight = .random(in: ClosedRange(uncheckedBounds: (10, 60.0)))
                    setsArr.append(exSet)
                }
                
                ex.sets = NSSet(array: setsArr)
            }
        }
        
        let newPerson = Person(context: viewContext)
        newPerson.name = "Andrii H."
        newPerson.weight = 86.5
        newPerson.fatPercent = 12
        
        
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
