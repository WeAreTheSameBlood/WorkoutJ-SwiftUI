//
//  AddWorkoutBtnView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI

struct AddWorkoutBtnView: View {
    var body: some View {
        HStack{
            NavigationLink(destination: CreateNewWorkout()) {
                Image(systemName: "plus")
                    .imageScale(.large)
            }
            .padding(15)
            .cornerRadius(45)
            .shadow(color: .black.opacity(0.3), radius: 3)
        }
    }
}

struct AddWorkoutBtnView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutBtnView()
    }
}
