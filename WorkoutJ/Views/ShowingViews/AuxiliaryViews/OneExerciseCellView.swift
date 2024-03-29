//
//  OneExerciseView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 17.05.2023.
//

import SwiftUI
import UserNotifications

struct OneExerciseCellView: View {
    
    @ObservedObject var exercise: Exercise
    
    @State private var timer: Timer? = nil
    @State private var timeRemaining: Int = 0
    @State private var introTextTimer: Bool = true
    @State private var timerCompleted: Bool = false
    @State private var timerIsWorking: Bool = false

    var body: some View {
        HStack {
            
            ( exercise.category != nil
            ? Rectangle()
                .frame(width: 5)
                .foregroundColor(Color(exercise.category?.color as! UIColor))
            : Rectangle()
                .frame(width: 5)
                .foregroundColor(.gray) )
            
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
                   cardioInfo()
                } else {
                    if (exercise.textToExercise != "") { Text("\(exercise.textToExercise ?? "Failer of text")").padding(7) }
                }
                
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(5)
            .onAppear { timeRemaining = Int(exercise.cardioTimer * 60) }
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        introTextTimer = false
        timerIsWorking = true
        timerCompleted = false
        
        makePUSHNotif()
        
        timeRemaining -= 1
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timerCompleted = true
                tempTimer.invalidate()
                timer = nil
            }
        }
    }
    
    private func makePUSHNotif() {
//        NotificationManagerService.shared.startTimerNotification(totalTime: timeRemaining)
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        timerIsWorking = false
        timer = nil
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        introTextTimer = true
        timerIsWorking = false
        timerCompleted = false
        timeRemaining = Int(exercise.cardioTimer) * 60
    }
    
    private func cardioInfo() -> AnyView {
        AnyView(
            ZStack {
                Rectangle()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor( .green.opacity(1) )
                GeometryReader { geometry in
                    Rectangle()
                        .frame( width: geometry.size.width * CGFloat(Float(timeRemaining) / Float(exercise.cardioTimer * 60)) > 0 ? geometry.size.width * CGFloat(Float(timeRemaining) / Float(exercise.cardioTimer * 60)) : 0 )
                        .foregroundColor( timerIsWorking ? .orange : .white.opacity(1/3))
                }
                
                HStack(spacing: 0) {
                    introTextTimer
                    ? ( Text("Planned time: \(exercise.cardioTimer) min").padding(7) )
                    : ( timerCompleted
                        ? Text("Cardio time: \(exercise.cardioTimer) min (Completed)").padding(7)
                        : Text("Cardio time: \(timeRemaining / 60) min \(timeRemaining % 60) sec\(timerIsWorking ? "" : " (Paused)")").padding(7)
                    )
                }
            }
            .onTapGesture(count: 2) { stopTimer() }
            .onTapGesture { timerIsWorking ? pauseTimer() : startTimer() }
            .cornerRadius(12)
        )
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
            })
    }
}

//struct OneExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneExerciseView()
//    }
//}
