//
//  PersonSizes+CoreDataProperties.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 21.05.2023.
//
//

import Foundation
import CoreData


extension PersonSizes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonSizes> {
        return NSFetchRequest<PersonSizes>(entityName: "PersonSizes")
    }

    @NSManaged public var neck: Double
    @NSManaged public var chest: Double
    @NSManaged public var shoulders: Double
    @NSManaged public var rightHand: Double
    @NSManaged public var leftHand: Double
    @NSManaged public var rightForearm: Double
    @NSManaged public var leftForearm: Double
    @NSManaged public var waist: Double
    @NSManaged public var rightLeg: Double
    @NSManaged public var leftLeg: Double
    @NSManaged public var rightGastrocnemius: Double
    @NSManaged public var leftGastrocnemius: Double
    @NSManaged public var person: Person?

}

extension PersonSizes : Identifiable {

}
