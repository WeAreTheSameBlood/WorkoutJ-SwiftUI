//
//  OneWorkoutInfoView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 20.05.2023.
//

import SwiftUI

struct OneWorkoutInfoView: View {
    
    @ObservedObject var workout: Workout
    
    var body: some View {
        
            NavigationLink(destination: OneWorkoutPlanView(workout: workout )) {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(workout.name ?? "Error of name")").opacity(1)
                        Spacer()
                    }
                    if (workout.desc != "")  {
                        HStack {
                            Text(workout.desc ?? "Error of desc")
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .opacity(2/3)
                            Spacer()
                        }
                    }
                    HStack {
                        ((workout.exercises?.count ?? 0) > 0
                         ? (Text("Exercises: \(String(describing: workout.exercises!.count))").opacity(1))
                         : (Text("No exercises").opacity(0.5)))
                        Spacer()
                    }
                    HStack {
                        workout.isComplete ? Text("Completed: \(dateToStr(date: (workout.completeDate ?? Date())))").opacity(1) : nil
                        Spacer()
                    }
                }
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(5)
        }
    
}

//struct OneWorkoutInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneWorkoutInfoView(workout: Workout())
//    }
//}
