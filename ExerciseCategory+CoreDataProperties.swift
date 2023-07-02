//
//  ExerciseCategory+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 28.06.2023.
//
//

import Foundation
import CoreData
import SwiftUI


extension ExerciseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseCategory> {
        return NSFetchRequest<ExerciseCategory>(entityName: "ExerciseCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var nameImage: String?
    @NSManaged public var color: NSObject?
    @NSManaged public var exercise: NSSet?

}

// MARK: Generated accessors for exercise
extension ExerciseCategory {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

extension ExerciseCategory : Identifiable {

}

extension ExerciseCategory {
    convenience init(name: String, imageName: String, schematicColor: Color) {
        self.init(context: PersistenceController.shared.container.viewContext)
        self.name = name
        self.nameImage = imageName
        self.color = UIColor(schematicColor)
    }
}
