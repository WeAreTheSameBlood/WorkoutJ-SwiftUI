//
//  OneWorkoutPlanView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 01.05.2023.
//

import SwiftUI

struct OneWorkoutPlanView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    @ObservedObject var workout: Workout
    
    var body: some View {
        ZStack {
            List {
                ForEach(workout.exersices?.allObjects as! [Exercise]) { ex in
                        Text("\(ex.name ?? "Name is empty") \nReps: \(ex.reps) \n\(ex.weight.formatted(.number)) kg")
                    }
                .onDelete(perform: deleteItems)
            }
            AddExerciseBtnView(workout: workout)
                .environmentObject(workout)
                .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
        }
        .navigationTitle(workout.name!)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { (workout.exersices?.allObjects as! [Exercise])[$0] }.forEach(viewContext.delete)
            dataHolder.saveContext(viewContext)
        }
    }
}

//struct OneWorkoutPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneWorkoutPlanView(workout: Workout() )
//    }
//}
