//
//  Person+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 25.05.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var fatPercent: Float
    @NSManaged public var name: String?
    @NSManaged public var weight: Float

}

extension Person : Identifiable {

}
