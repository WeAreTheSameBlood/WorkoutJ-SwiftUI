//
//  Person+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 21.05.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var fatPercent: Double
    @NSManaged public var sizes: PersonSizes?
    @NSManaged public var performance: NSSet?

}

// MARK: Generated accessors for performance
extension Person {

    @objc(addPerformanceObject:)
    @NSManaged public func addToPerformance(_ value: PersonPerformance)

    @objc(removePerformanceObject:)
    @NSManaged public func removeFromPerformance(_ value: PersonPerformance)

    @objc(addPerformance:)
    @NSManaged public func addToPerformance(_ values: NSSet)

    @objc(removePerformance:)
    @NSManaged public func removeFromPerformance(_ values: NSSet)

}

extension Person : Identifiable {

}
