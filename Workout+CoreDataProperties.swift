//
//  Workout+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 21.06.2023.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var completeDate: Date?
    @NSManaged public var createdDate: Date?
    @NSManaged public var desc: String?
    @NSManaged public var expectedDate: Date?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var onDateBool: Bool
    @NSManaged public var serial: Int32
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercises
extension Workout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Workout : Identifiable {

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
