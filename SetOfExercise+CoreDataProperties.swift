//
//  SetOfExercise+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 14.05.2023.
//
//

import Foundation
import CoreData


extension SetOfExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetOfExercise> {
        return NSFetchRequest<SetOfExercise>(entityName: "SetOfExercise")
    }

    @NSManaged public var reps: Int16
    @NSManaged public var serial: Int32
    @NSManaged public var weight: Float
    @NSManaged public var toExersice: Exercise?

}

extension SetOfExercise : Identifiable {

}

extension SetOfExercise {
    func toModel() -> SetOfExerciseShareModel {
        return SetOfExerciseShareModel(
                                reps: reps,
                                serial: serial,
                                weight: weight)
    }
}
