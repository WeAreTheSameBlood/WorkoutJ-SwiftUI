//
//  UIAlertService.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 25.08.2023.
//

import SwiftUI

class UIAlertService {
    
    private init() {}
    public static let shared = UIAlertService()
    
    public func showAuthorizationErrorAlert() {
        let viewController = UIApplication.shared.windows.first?.rootViewController
        
        let alert = UIAlertController(title: "Authorization Error",
                                      message: "Failed to authorize access to HealthKit.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: { _ in
            HealthKitService.shared.requestAuthorization()
        }))

        viewController?.present(alert, animated: true, completion: nil)
    }
    
    public func showOtherAlert() {
        // write code here, kekw <3
    }

}
