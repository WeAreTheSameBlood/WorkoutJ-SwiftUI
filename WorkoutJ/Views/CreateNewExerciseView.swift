//
//  CreateNewExerciseView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 01.05.2023.
//

import SwiftUI

struct CreateNewExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder

    @State var newExercise: Exercise?
    @State var name: String
    @State var weightStr: String
    @State var weightFloat: Float
    @State var repsStr: String
    @State var repsInt: Int16
    @State var inWorkout: Workout
    
    init(inWorkout: Workout) {
        _name = State(initialValue: "")
        _weightStr = State(initialValue: "")
        _weightFloat = State(initialValue: 0)
        _repsStr = State(initialValue: "")
        _repsInt = State(initialValue: 0)
        _inWorkout = State(initialValue: inWorkout)
    }
    
    var body: some View {
        Form {
            Section(header: Text("New exercise")) {
                TextField("Name", text: $name)
                TextField("Weght", text: $weightStr)
                    .keyboardType(.decimalPad)
                TextField("Reps", text: $repsStr)
                    .keyboardType(.numberPad)
            }
            Section {
                Button("Save", action: saveNewExercise)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func saveNewExercise() {
        newExercise = Exercise(context: viewContext)
        newExercise?.name = name != "" ? name : "Name is empty"
        newExercise?.weight = weightStr != "" ? Float(weightStr.replacingOccurrences(of: ",", with: "."))! : 0.0
        newExercise?.reps = repsStr != "" ? Int16(repsStr)! : 0
        newExercise?.inWorkout = inWorkout
        
        dataHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
}

//struct CreateNewExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewExerciseView()
//    }
//}
