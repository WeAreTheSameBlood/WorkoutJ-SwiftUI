//
//  ExerciseCategories.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 27.06.2023.
//

import SwiftUI

struct CreatorManager {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder

//    let BASIC_CATEGORIES: [ExerciseCategory] = [
//            ExerciseCategory(name: "Basic", imageName: "figure.strengthtraining.traditional", schematicColor: .blue),
//            ExerciseCategory(name: "Cardio", imageName: "figure.indoor.cycle", schematicColor: .yellow),
//            ExerciseCategory(name: "Warm-up", imageName: "figure.cooldown", schematicColor: .orange),
//            ExerciseCategory(name: "Stretching", imageName: "figure.flexibility", schematicColor: .mint),
//            ExerciseCategory(name: "Hang-up", imageName: "figure.rolling", schematicColor: .brown),
//            ]
//
//    public func createBasicCategories() {
//        for basicCategory in BASIC_CATEGORIES {
//            let category = ExerciseCategory(context: viewContext)
//            category.name = basicCategory.name
//            category.nameImage = basicCategory.nameImage
//            category.color = basicCategory.color
//            dataHolder.saveContext(viewContext)
//        }
//    }
}

//let DEFAULT_CATEGORIES: [ExerciseCategory] = [
//    ExerciseCategory(name: "Basic", imageName: "figure.strengthtraining.traditional", schematicColor: .blue),
//    ExerciseCategory(name: "Cardio", imageName: "figure.indoor.cycle", schematicColor: .yellow),
//    ExerciseCategory(name: "Warm-up", imageName: "figure.cooldown", schematicColor: .orange),
//    ExerciseCategory(name: "Stretching", imageName: "figure.flexibility", schematicColor: .mint),
//    ExerciseCategory(name: "Hang-up", imageName: "figure.rolling", schematicColor: .brown),
//    ]
