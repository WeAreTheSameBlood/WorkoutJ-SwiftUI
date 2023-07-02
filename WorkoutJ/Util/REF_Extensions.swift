//
//  ToModelExtension.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 10.05.2023.
//

/*
 
 extension SetOfExercise {
     func toModel() -> SetOfExerciseShareModel {
         return SetOfExerciseShareModel(
                                 reps: reps,
                                 serial: serial,
                                 weight: weight)
     }
 }

 extension Exercise {
     func toModel() -> ExerciseShareModel {
         return ExerciseShareModel(
                             name: name ?? "Exersice name is empty",
                             serial: serial,
                             desc: desc,
                             sets: (sets?.allObjects as! [SetOfExercise]).map{$0.toModel()})
     }
 }
 
 extension Workout {
     func toModel() -> WorkoutShareModel {
         return WorkoutShareModel(
                             name: name ?? "Name is empty",
                             isComplete: isComplete,
                             desc: desc,
                             completeDate: completeDate,
                             expectedDate: expectedDate,
                             exersices: [])
     }
 }
 
 extension ExerciseCategory {
     convenience init(name: String, imageName: String, schematicColor: Color) {
         self.init(context: PersistenceController.shared.container.viewContext)
         self.name = name
         self.nameImage = imageName
         self.color = UIColor(schematicColor)
     }
 }

 
*/
