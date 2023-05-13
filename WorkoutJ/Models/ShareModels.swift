//
//  ExportModels.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

struct WorkoutShareModel : Codable {
    
    public var name: String
    public var isComplete: Bool
    public var desc: String?
    public var completeDate: Date?
    public var expectedDate: Date?
    public var exersices: [ExerciseShareModel]
    
}

struct ExerciseShareModel : Codable {
    
    public var name: String
    public var serial: Int32
    public var desc: String?
    public var sets: [SetOfExerciseShareModel]
    
}

struct SetOfExerciseShareModel : Codable {
    
    public var reps: Int16
    public var serial: Int32
    public var weight: Float
    
}
