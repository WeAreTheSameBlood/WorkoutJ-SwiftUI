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
                                HStack {
                                    Text("\(exercise.name!)").frame(alignment: .leading)
                                    Spacer()
                                }
                                exerciseInfo(exercise: exercise)
                    
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
        csvShareWorkout(workoutForShare: workout)
    }
    
    private func exerciseInfo(exercise: Exercise) -> AnyView {
        
        guard exercise.sets!.count > 0 else { return AnyView( Text("Sets not yet added").opacity(0.5)) }
        
        let sets = exercise.sets!.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [SetOfExercise]
        var setsInfo = ""
        
        for oneSet in sets {
            setsInfo += "\n\tWeight: \(String(format: "%.1f", oneSet.weight)) kg\tReps: \(oneSet.reps)"
        }
        
        return AnyView(
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(sets) {oneSet in
                            OneSetView(oneSet: oneSet)
                        }
                    }
                }
            }
        )
        
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
