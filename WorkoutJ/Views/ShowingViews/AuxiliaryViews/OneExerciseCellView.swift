//
//  OneExerciseView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 17.05.2023.
//

import SwiftUI

struct OneExerciseCellView: View {
    
    @ObservedObject var exercise: Exercise
    
    var body: some View {
        HStack {
            
            (exercise.category != nil
             ? Rectangle()
                .frame(width: 5)
                .foregroundColor(Color(exercise.category?.color as! UIColor))
             : Rectangle()
                .frame(width: 5)
                .foregroundColor(.gray)
            )
            
            VStack(spacing: 1) {
                HStack {
                    Text("\(exercise.name ?? "Error name exercise")").frame(alignment: .leading)
                    Spacer()
                }
                if ((exercise.desc ?? "Error desc in exercise") != "") {
                    HStack {
                        Text("\(exercise.desc ?? "Error desc in exercise")")
                            .padding(5)
                            .frame(alignment: .leading)
                            .opacity(2/3)
                        Spacer()
                    }
                }
                if (exercise.category?.name == "Basic") {
                    setsOfExerciseInfo(exercise: exercise)
                } else if (exercise.category?.name == "Cardio") {
                    VStack(spacing: 0) {
                        Text("Cardio time: \(exercise.cardioTimer) min").padding(7)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                } else {
                    if (exercise.textToExercise != "") { Text("\(exercise.textToExercise ?? "Failer of text")").padding(7) }
                }
                
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(5)
        }
    }
    
    private func setsOfExerciseInfo(exercise: Exercise) -> AnyView {
        guard exercise.category?.name == "Basic" else {return AnyView(EmptyView())}
        guard (exercise.sets?.count ?? 0) > 0 else { return AnyView( Text("Sets not yet added").opacity(0.5)) }
        let sets = exercise.sets!.sortedArray(using: [NSSortDescriptor(key: "serial", ascending: true)]) as! [SetOfExercise]
        
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
