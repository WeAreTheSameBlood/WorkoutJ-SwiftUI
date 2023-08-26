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
    
    @State private var selectedExerciseForUpdate: Exercise?
    @State private var showInfo: Bool = false
    
    var body: some View {
        ZStack {
            List {
                if (workout.desc ?? "" != "") {
                    Section(header: Text("Description")) {
                        Text(workout.desc ?? "Error description")
                    }
                }
                if ((workout.exercises?.count ?? 0) > 0) {
                    Section(header: Text("Exercises")) {
                        ForEach(workout.exercises?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [Exercise]) { exercise in
                            VStack {
                                OneExerciseCellView(exercise: exercise)
                                    .swipeActions(edge: .leading) {
                                        
                                        // Update one workout
                                        Button { selectedExerciseForUpdate = exercise } label: {
                                            Label("Update", systemImage: "square.and.pencil")
                                        }
                                        .tint(.green)
                                    }
                                    .sheet(item: $selectedExerciseForUpdate) { exercise in
                                        CreateUpdateExerciseView(exercise: exercise)
                                            .onDisappear { selectedExerciseForUpdate = nil }
                                    }
                                    .swipeActions(edge: .trailing) {
                                        
                                        // Delete one workout
                                        Button(role: .destructive) {
                                            deleteExercise(exerciseToDelete: exercise)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                        .onMove(perform: moveExercise)
                    }
                } else {
                    Text("No exercises have been added yet")
                        .opacity(0.5)
                        .padding(15)
                        .multilineTextAlignment(.center)
                }
                if ((workout.exercises?.count ?? 0) > 0) {
                    workoutInfoSection(workout: workout)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: shareWorkout) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            AddExerciseBtnView(workout: workout)
                .environmentObject(workout)
                .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
            }
        .navigationTitle(workout.name ?? "")
    }
    
    func shareWorkout() {
        shareWorkoutLikeStr(workoutForShare: workout)
    }
    
    private func moveExercise(from source: IndexSet, to destination: Int) {
        var sortedExercises = workout.exercises?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [Exercise]
        withAnimation {
            sortedExercises.move(fromOffsets: source, toOffset: destination)
            updateSerialInArray(array: sortedExercises)
            
            workout.exercises? = NSSet(array: sortedExercises)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func deleteExercise(exerciseToDelete: Exercise) {
        withAnimation {
            viewContext.delete(exerciseToDelete)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func updateSerialInArray(array: [Exercise]) {
        for i in 0..<array.count {
            array[i].serial = Int32(i)
        }
    }
    
    private func workoutInfoSection(workout: Workout) -> AnyView {
        return AnyView(
            Section(header: Text("Information")) {
                Text(showInfo ? "Tap to hide info" : "Tap to show info")
                    .opacity(2/3)
                    .onTapGesture {
                        showInfo = !showInfo
                    }
                if (showInfo) {
                    Text("""
                     Exercises: \(workout.exercises!.count)
                     Expected date: \(workout.expectedDate != nil ? dateToStr(date: workout.expectedDate!) : "---")
                     Complete date: \(workout.completeDate != nil ? dateToStr(date: workout.completeDate!) : "---")
                     """)
                }
            }
        )
    }
}

//struct OneWorkoutPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneWorkoutPlanView(workout: Workout() )
//    }
//}
