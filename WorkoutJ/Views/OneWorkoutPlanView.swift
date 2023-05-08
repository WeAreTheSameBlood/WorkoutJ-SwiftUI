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
                if (workout.desc != "") {
                    Section(header: Text("Description")) {
                        Text(workout.desc ?? "Empty description")
                    }
                }
                if (workout.exersices!.count > 0) {
                    Section(header: Text("Exercises")) {
                        ForEach(workout.exersices?.allObjects as! [Exercise]) { ex in
                            Text("\(ex.name!) \nWeight: \(String(format: "%.1f", ex.weight)) kg \nReps: \(ex.reps)")
                        }
                        .onDelete(perform: deleteExercise)
                        .onMove(perform: moveExercise)
                    }
                } else {
                    Text("No exercises have been added yet")
                        .padding(15)
                        .multilineTextAlignment(.center)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            AddExerciseBtnView(workout: workout)
                .environmentObject(workout)
                .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
        }
        .navigationTitle(workout.name!)
    }
    
    private func moveExercise(from source: IndexSet, to destination: Int) {
        
        var exArray = Array(workout.exersices!)
        exArray.move(fromOffsets: source, toOffset: destination)
        
        dataHolder.saveContext(viewContext)
    }
    
    private func deleteExercise(offsets: IndexSet) {
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
