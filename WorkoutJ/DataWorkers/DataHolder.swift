//
//  DataHolder.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI
import CoreData

class DataHolder : ObservableObject{
    
    init(_ context: NSManagedObjectContext) {
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            print(Date().formatted(.dateTime))
        }
    }
}
