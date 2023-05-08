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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.serial, ascending: false)],
        animation: .default)
    var workouts: FetchedResults<Workout>

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
                                    NavigationLink(destination: OneWorkoutPlanView(workout: workout))
                                    {
                                        WorkoutCellView(workout: workout)
                                            .environmentObject(dataHolder)
                                    }
                                }
                            }
                            .onDelete(perform: deleteWorkout)
                            .onMove(perform: moveWorkout)
                        }
                        Section(header: Text("Completed")) {
                            ForEach(workouts) { workout in
                                if (workout.isComplete == true) {
                                    NavigationLink(destination: OneWorkoutPlanView(workout: workout))
                                    {
                                        WorkoutCellView(workout: workout)
                                            .environmentObject(dataHolder)
                                    }
                                }
                            }
                            .onDelete(perform: deleteWorkout)
                            .onMove(perform: moveWorkout)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                AddWorkoutBtnView()
                    .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
            }
        .navigationTitle(Text("Workouts"))
        }
    }
    
    private func deleteWorkout(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func moveWorkout(from source: IndexSet, to destination: Int) {
        var workoutsArray = Array(workouts)
        workoutsArray.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<workoutsArray.count {
            workoutsArray[workoutsArray.count-1-i].serial = Int32(i)
        }
        
        dataHolder.saveContext(viewContext)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
    }
}
