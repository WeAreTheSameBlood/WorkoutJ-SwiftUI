//
//  WorkoutCell.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

struct OneWorkoutCellView: View {
    
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var workout: Workout
    
    var body: some View {
        HStack {
            
            CheckBoxView(workout: workout)
                .environmentObject(dataHolder)
            
            OneWorkoutInfoView(workout: workout)
            
        }
    }
    
//    private func dateToStr(date: Date) -> String{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        return formatter.string(from: date)
//    }
}
