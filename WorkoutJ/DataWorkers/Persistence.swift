//
//  Persistence.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import CoreData
import SwiftUI

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let personProps = Person(context: viewContext)
        personProps.serial = Int16(0)
        personProps.name = "Default name"
        personProps.weight = 88.6
        personProps.fatPercent = 12.3
        
        let catName: [String] = ["Basic", "Cardio", "Warm-up", "Stretching", "Hang-up"]
        let catImg: [String] = ["figure.strengthtraining.traditional", "figure.indoor.cycle", "figure.cooldown", "figure.flexibility", "figure.rolling"]
        let catColor: [Color] = [.blue, .mint, .orange, .red, .brown]
        
        var categs: [ExerciseCategory] = []
        for categ in 0...4 {
            let newCateg = ExerciseCategory(context: viewContext)
            newCateg.serial = Int16(categ+1)
            newCateg.name = catName[categ]
            newCateg.nameImage = catImg[categ]
            newCateg.color = UIColor( catColor[categ] )
            categs.append(newCateg)
        }
        
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
            
            ex1.desc = "111"
            ex2.desc = "222ad as 330"
            ex3.desc = "333"
            
            ex1.cardioTimer = 10
//            ex2.cardioTimer = 20
            ex3.cardioTimer = 15
            
            ex1.serial = 0
            ex2.serial = 1
            ex3.serial = 2
            
            ex1.category = categs[0]
            ex2.category = categs[0]
            ex3.category = categs[0]
            
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
