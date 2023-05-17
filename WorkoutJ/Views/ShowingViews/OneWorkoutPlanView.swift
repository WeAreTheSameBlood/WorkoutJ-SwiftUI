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
    
    @State var toUpdateExercise: Bool = false
    
    var body: some View {
        let sortedExercises = workout.exersices?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [Exercise]
        
        ZStack {
            List {
                if (workout.desc != "") {
                    Section(header: Text("Description")) {
                        Text(workout.desc!)
                    }
                }
                if (sortedExercises.count > 0) {
                    Section(header: Text("Exercises")) {
                        ForEach(sortedExercises) { exercise in
                            VStack {
                                OneExerciseView(exercise: exercise)
                                    .swipeActions(edge: .leading) {
                                        
                                        /*
                                         Found bug with update realization
                                         If you use exercise as parameter for CreateUpdateExerciseView(exercise: exercise),
                                         you will open view with first exercise in exercises
                                         */
                                        
                                        // Update one workout
                                        Button { toUpdateExercise = !toUpdateExercise } label: {
                                            Label("Update", systemImage: "square.and.pencil")
                                        }
                                        .tint(.green)
                                    }
                                    .sheet(isPresented: $toUpdateExercise) {
                                        CreateUpdateExerciseView(exercise: exercise)
                                    }
                            }
                        }
                        .onDelete(perform: deleteExercise)
                        .onMove(perform: moveExercise)
                    }
                } else {
                    Text("No exercises have been added yet")
                        .opacity(0.5)
                        .padding(15)
                        .multilineTextAlignment(.center)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: shareWorkout) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    EditButton()
                }
            }
            AddExerciseBtnView(workout: workout)
                .environmentObject(workout)
                .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
            }
        .navigationTitle(workout.name!)
    }
    
    func shareWorkout() {
        shareWorkoutLikeStr(workoutForShare: workout)
    }
    
    private func moveExercise(from source: IndexSet, to destination: Int) {
        var sortedExercises = workout.exersices?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [Exercise]
        withAnimation {
            sortedExercises.move(fromOffsets: source, toOffset: destination)
            updateSerialInArray(array: sortedExercises)
            
            workout.exersices? = NSSet(array: sortedExercises)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        var sortedExercises = workout.exersices?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [Exercise]
        withAnimation {
            sortedExercises.remove(atOffsets: offsets)
            updateSerialInArray(array: sortedExercises)
            
            workout.exersices? = NSSet(array: sortedExercises)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func updateSerialInArray(array: [Exercise]) {
        for i in 0..<array.count {
            array[i].serial = Int32(i)
        }
    }
}

//struct OneWorkoutPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneWorkoutPlanView(workout: Workout() )
//    }
//}
