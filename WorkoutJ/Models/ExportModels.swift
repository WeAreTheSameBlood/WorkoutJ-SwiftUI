//
//  ExportModels.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

struct WorkoutExportModel : Codable {
    
    public var name: String
    public var isComplete: Bool
    public var desc: String?
    public var completeDate: Date?
    public var expectedDate: Date?
    public var exersices: [ExerciseExportModel]
    
}

struct ExerciseExportModel : Codable {
    public var name: String
//    public var sets: [SetOfExercise]
}
