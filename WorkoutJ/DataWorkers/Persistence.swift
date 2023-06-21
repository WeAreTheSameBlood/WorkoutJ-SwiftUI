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
            newWorkout.exercises = []
            
            ex1.name = "Exercise name for \(num) workout"
            ex2.name = "Exercise name for \(num) workout"
            ex3.name = "Exercise name for \(num) workout"
            
            ex1.desc = ""
            ex2.desc = ""
            ex3.desc = ""
            
            ex1.serial = 0
            ex2.serial = 1
            ex3.serial = 2

            newWorkout.exercises = [ex1, ex2, ex3]
            
            for ex in (newWorkout.exercises?.allObjects as! [Exercise]) {
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
        
        let personProps = Person(context: viewContext)
        personProps.serial = Int16(0)
        personProps.name = "Default name"
        personProps.weight = 88.6
        personProps.fatPercent = 12.3
        
//        let size1 = PersonSizes(context: viewContext)
//        size1.chest = 40
//        size1.leftForearm = 40
//        size1.rightForearm = 40
//        size1.neck = 40
//        size1.leftLeg = 40
//        size1.rightLeg = 40
//        size1.leftGastrocnemius = 40
//        size1.rightGastrocnemius = 40
//        size1.leftHand = 40
//        size1.rightHand = 50
//        size1.shoulders = 50
//        size1.waist = 50
//        personProps.sizes = size1
//
//        let perf = PersonPerformance(context: viewContext)
//        perf.nameExersice = "Name of 1 perf"
//        perf.weight = 123
//        perf.percentOfMax = 60
        
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
