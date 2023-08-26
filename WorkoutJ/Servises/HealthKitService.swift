//
//  HealthKitService.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 25.08.2023.
//

import HealthKit
import UIKit


class HealthKitService {
    
    private init() {}
    public static let shared = HealthKitService()
    
    private let healthStore = HKHealthStore()
    private let allTypes = Set([HKObjectType.workoutType()])
    
    
    public func requestAuthorization() {
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                UIAlertService.shared.showAuthorizationErrorAlert()
            }
        }
    }
    
    public func saveWorkout(finishDate: Date) {
        
        let workoutToSave = HKWorkout(
            activityType: .other,
            start: finishDate,
            end: finishDate
        )

        healthStore.save(workoutToSave) { (success, error) in
            if !success {
                // Handle the error here.
            }
        }
    }
}
