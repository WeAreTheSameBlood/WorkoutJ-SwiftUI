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
    private var workouts: FetchedResults<Workout>

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: OneWorkoutPlanView(workout: workout))
                        {
                            Text(workout.name! + "  \(String(describing: workout.exersices?.count))")
                        }
                    }
                    .onDelete(perform: deleteItems)
//                    .onMove(perform: moveWorkouts)
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)
            dataHolder.saveContext(viewContext)
        }
    }
    
    private func moveWorkouts(from source: IndexSet, to destination: Int) {
        /**
         Create logic for move func
         */
        dataHolder.saveContext(viewContext)
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
    }
}
