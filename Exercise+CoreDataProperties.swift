//
//  Exercise+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Float
    @NSManaged public var reps: Int16
    @NSManaged public var inWorkout: Workout?

}

extension Exercise : Identifiable {

}
