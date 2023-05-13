//
//  Workout+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 14.05.2023.
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
    @NSManaged public var exersices: NSSet?

}

// MARK: Generated accessors for exersices
extension Workout {

    @objc(addExersicesObject:)
    @NSManaged public func addToExersices(_ value: Exercise)

    @objc(removeExersicesObject:)
    @NSManaged public func removeFromExersices(_ value: Exercise)

    @objc(addExersices:)
    @NSManaged public func addToExersices(_ values: NSSet)

    @objc(removeExersices:)
    @NSManaged public func removeFromExersices(_ values: NSSet)

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
