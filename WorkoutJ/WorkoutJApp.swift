//
//  WorkoutJApp.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI

@main
struct WorkoutJApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        let context = persistenceController.container.viewContext
        let dataHolder = DataHolder(context)
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
                .environmentObject(dataHolder)
        }
    }
}
