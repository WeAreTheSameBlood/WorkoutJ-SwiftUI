//
//  Exercise+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var serial: Int32
    @NSManaged public var inWorkout: Workout?
    @NSManaged public var sets: NSSet?

}

// MARK: Generated accessors for sets
extension Exercise {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: SetOfExercise)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: SetOfExercise)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}

extension Exercise : Identifiable {

}

extension Exercise {
    func toModel() -> ExerciseExportModel {
        return ExerciseExportModel(name: name ?? "Exersice name is empty")
    }
}
