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
        let sortedExercises = workout.exersices?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: false)]) as! [Exercise]
        
        ZStack {
            
            List {
                if (workout.desc != "") {
                    Section(header: Text("Description")) {
                        Text(workout.desc ?? "Empty description")
                    }
                }
                if (sortedExercises.count > 0) {
                    Section(header: Text("Exercises")) {
                        ForEach(sortedExercises) { exercise in
                            VStack {
                                HStack {
                                    Text("")
                                        .frame(width: UIScreen.main.bounds.width/8)
                                    Text("\(exercise.serial) | \(exercise.name!)")
                                        
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
                        .padding(15)
                        .multilineTextAlignment(.center)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: exportWorkout) {
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
    
    func exportWorkout() {
        csvExportWorkout(workoutForExport: workout)
    }
    
    private func exerciseInfo(exercise: Exercise) -> some View {
        let sets = exercise.sets!.allObjects as! [SetOfExercise]
        var setsInfo = ""
        
        for oneSet in sets {
            setsInfo += "\n\tWeight: \(String(format: "%.1f", oneSet.weight)) kg\tReps: \(oneSet.reps)"
        }
        
        
        return VStack {
                ForEach(sets) { oneSet in
                    HStack {
                        Text("").frame(width: UIScreen.main.bounds.width/5)
                        Text("Weight: \(String(format: "%.1f", oneSet.weight)) kg")
                            .frame(width: UIScreen.main.bounds.width/2.5, alignment: .leading)
                        Text("Reps: \(oneSet.reps)")
                            .frame(width: UIScreen.main.bounds.width/2.5, alignment: .leading)
                    }
                    //                Text(exercise.sets!.count > 0 ? setsInfo : "")
                }
            }
        
        
    }
    
    private func moveExercise(from source: IndexSet, to destination: Int) {
        
        var exArray = workout.exersices?.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: false)]) as! [Exercise]
        exArray.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<exArray.count {
            exArray[exArray.count-1-i].serial = Int32(i)
        }
        
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
