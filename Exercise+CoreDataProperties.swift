//
//  Exercise+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 14.05.2023.
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
    @NSManaged public var desc: String?
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
    func toModel() -> ExerciseShareModel {
        return ExerciseShareModel(
                            name: name ?? "Exersice name is empty",
                            serial: serial,
                            desc: desc,
                            sets: (sets?.allObjects as! [SetOfExercise]).map{$0.toModel()})
    }
}
