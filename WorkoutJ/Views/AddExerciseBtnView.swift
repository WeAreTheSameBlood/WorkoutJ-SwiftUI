//
//  AddExerciseBtnView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 01.05.2023.
//

import SwiftUI

struct AddExerciseBtnView: View {
    @ObservedObject var workout: Workout
    
    var body: some View {
        HStack{
            NavigationLink(destination: CreateNewExerciseView(inWorkout: workout)
                .environmentObject(workout)) {
                Image(systemName: "plus")
            }
            .padding(15)
            .cornerRadius(45)
            .shadow(color: .black.opacity(0.3), radius: 3)
        }
    }
}

//struct AddExerciseBtnView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExerciseBtnView()
//    }
//}
