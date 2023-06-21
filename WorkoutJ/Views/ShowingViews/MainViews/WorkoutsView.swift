//
//  ContentView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Workout.serial, ascending: false)])
    var workouts: FetchedResults<Workout>
    
    @State private var selectedWorkoutForUpdate: Workout?
    @State private var toPersonView = false

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if (workouts.isEmpty) {
                        Text("No workouts have been added yet")
                            .padding(15)
                            .multilineTextAlignment(.center)
                    } else {
                        Section(header: Text("Planed")) {
                            ForEach(workouts) { workout in
                                if (workout.isComplete == false) {
                                    VStack {
                                        OneWorkoutCellView(workout: workout).environmentObject(dataHolder)
                                            .swipeActions(edge: .leading) {
                                                
                                                // Share one workout
                                                Button { shareWorkoutLikeStr(workoutForShare: workout) } label: {
                                                    Label("Share", systemImage: "square.and.arrow.up")
                                                }
                                                .tint(.blue)
                                                
                                                // Update one workout
                                                Button { selectedWorkoutForUpdate = workout } label: {
                                                    Label("Edit", systemImage: "square.and.pencil")
                                                }
                                                .tint(.green)
                                            }
                                            .sheet(item: $selectedWorkoutForUpdate) { workout in
                                                CreateUpdateWorkoutView(workout: workout)
                                                    .onDisappear { selectedWorkoutForUpdate = nil }
                                            }
                                            .swipeActions(edge: .trailing) {
                                                
                                                // Delete one workout
                                                Button(role: .destructive) {
                                                    deleteWorkout(workoutToDelete: workout)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                                .tint(.red)
                                            }
                                    }
                                }
                            }
                            .onMove(perform: moveWorkout)
                        }
                        Section(header: Text("Completed")) {
                            ForEach(workouts) { workout in
                                if (workout.isComplete == true) {
                                    OneWorkoutCellView(workout: workout).environmentObject(dataHolder)
                                    .swipeActions(edge: .leading) {

                                        // Share one workout
                                        Button { shareWorkoutLikeStr(workoutForShare: workout) } label: {
                                            Label("Share", systemImage: "square.and.arrow.up")
                                        }
                                        .tint(.blue)

                                        // Update one workout
                                        Button { selectedWorkoutForUpdate = workout } label: {
                                            Label("Edit", systemImage: "square.and.pencil")
                                        }
                                        .tint(.green)
                                        
                                        // Clone one workout
                                        Button {cloneOneWorkout(workout: workout)} label: {
                                            Label("Clone", systemImage: "doc.on.doc")
                                        }
                                        .tint(.orange)
                                    }
                                    .sheet(item: $selectedWorkoutForUpdate) { workout in
                                        CreateUpdateWorkoutView(workout: workout)
                                            .onDisappear { selectedWorkoutForUpdate = nil }
                                    }
                                    
                                    .swipeActions(edge: .trailing) {
                                        
                                        // Delete one workout
                                        Button(role: .destructive) {
                                            deleteWorkout(workoutToDelete: workout)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }
                                }
                            }
                            .onMove(perform: moveWorkout)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        // Open person's view
                        OpenPersonStatsBtnView()
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(dataHolder)
                    }
                }
                AddWorkoutBtnView()
                    .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
            }
        .navigationTitle(Text("Workouts"))
        }
    }
    
    private func share(for workout: Workout) {
        shareWorkoutLikeStr(workoutForShare: workout)
    }
    
    private func cloneOneWorkout(workout: Workout) {
    }
    
    private func deleteWorkout(workoutToDelete: Workout) {
        withAnimation {
            viewContext.delete(workoutToDelete)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func moveWorkout(from source: IndexSet, to destination: Int) {
        var workoutsArray: [Workout] = Array(workouts)
        workoutsArray.move(fromOffsets: source, toOffset: destination)
        updateSerialInArray(array: workoutsArray)

        dataHolder.saveContext(viewContext)
    }
    
    private func updateSerialInArray(array: [Workout]) {
        for i in 0..<array.count {
            array[array.count-i-1].serial = Int32(i)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
    }
}
