//
//  PersonPerformance+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 25.05.2023.
//
//

import Foundation
import CoreData


extension PersonPerformance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonPerformance> {
        return NSFetchRequest<PersonPerformance>(entityName: "PersonPerformance")
    }

    @NSManaged public var nameExersice: String?
    @NSManaged public var percentOfMax: Int16
    @NSManaged public var weight: Double

}

extension PersonPerformance : Identifiable {

}
