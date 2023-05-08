//
//  CheckBoxView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 08.05.2023.
//

import SwiftUI

struct CheckBoxView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var workout: Workout
    
    var body: some View {
        Image(systemName: workout.isComplete
              ? "checkmark.circle.fill"
              : "circle")
        .foregroundColor(workout.isComplete
                         ? .green
                         : .secondary)
        .onTapGesture {
            withAnimation {
                workout.isComplete = !workout.isComplete
                workout.completeDate = workout.isComplete ? Date() : nil
                dataHolder.saveContext(viewContext)
            }
        }
    }
}

//struct CheckBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckBoxView()
//    }
//}
