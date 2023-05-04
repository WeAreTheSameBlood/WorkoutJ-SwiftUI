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
    @State var weight: Float
    @State var reps: Int
    @State var inWorkout: Workout?
    
    init(inWorkout: Workout) {
        _name = State(initialValue: "")
        _weight = State(initialValue: Float())
        _reps = State(initialValue: Int())
        _inWorkout = State(initialValue: inWorkout)
    }
    
    var body: some View {
        Form {
            Section(header: Text("General info")) {
                TextField("Name", text: $name)
                TextField("Weght", value: $weight, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                TextField("Reps", value: $reps, formatter: NumberFormatter())
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
        newExercise?.weight = weight
        newExercise?.reps = Int16(reps)
        
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
