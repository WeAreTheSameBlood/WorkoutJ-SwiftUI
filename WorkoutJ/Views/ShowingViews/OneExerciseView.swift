//
//  OneExerciseView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 17.05.2023.
//

import SwiftUI

struct OneExerciseView: View {
    
    @ObservedObject var exercise: Exercise
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(exercise.name!)").frame(alignment: .leading)
                Spacer()
            }
            if (exercise.desc! != "") {
                HStack {
                    Text("\(exercise.desc!)")
                        .frame(alignment: .leading)
                        .opacity(2/3)
                    Spacer()
                }
            }
            setsOfExerciseInfo(exercise: exercise)
        }
        .listStyle(InsetListStyle())
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(5)
    }
    
    private func setsOfExerciseInfo(exercise: Exercise) -> AnyView {
        
        guard exercise.sets!.count > 0 else { return AnyView( Text("Sets not yet added").opacity(0.5)) }
        
        let sets = exercise.sets!.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [SetOfExercise]
//        var setsInfo = ""
//
//        for oneSet in sets {
//            setsInfo += "\n\tWeight: \(String(format: "%.1f", oneSet.weight)) kg\tReps: \(oneSet.reps)"
//        }
        
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
}

//struct OneExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneExerciseView()
//    }
//}
