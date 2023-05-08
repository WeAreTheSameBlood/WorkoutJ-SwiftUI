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
    @State var sets: [SetOfExercise]
    @State var inWorkout: Workout
    
    @State var numOfFields: Int = 1
    
    @State var fieldsOfSet: [Int : [String:String]] = [:]
    
    @State var weightArr : [String] = Array(repeating: "", count: 100)
    @State var repsArr : [String] = Array(repeating: "", count: 100)
    
    init(inWorkout: Workout) {
        _name = State(initialValue: "")
        _sets = State(initialValue: [])
        _inWorkout = State(initialValue: inWorkout)
    }
    
    var body: some View {
        @State var weight: String = ""
        @State var reps: String = ""
        
        Form {
            Section(header: Text("New exercise")) {
                TextField("Name", text: $name)
            }
            Section(header: Text("Parameters on sets")) {
                ForEach(0 ..< numOfFields) { numOfSet in

                    HStack {
                        Text("Set № \(numOfSet+1):\t")
                        TextField("Weight", text: $weightArr[numOfSet])
                            .keyboardType(.decimalPad)
                        TextField("Reps", text: $repsArr[numOfSet])
                            .keyboardType(.numberPad)
                    }

                }
            }
            .id(numOfFields)
            
            Button("Add Set Field", action: addFieldOfSet)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Section {
                Button("Save", action: saveNewExercise)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func addFieldOfSet() {
        for num in 0 ... numOfFields {
            var setsField: [String : String] = [:]
            setsField["Weight"] = weightArr[num]
            setsField["Reps"] = repsArr[num]
            fieldsOfSet[num+1] = setsField
        }
        numOfFields += 1
    }

    private func saveNewExercise() {
        newExercise = Exercise(context: viewContext)
        newExercise?.name = name != "" ? name : "Name is empty"
        newExercise?.serial = inWorkout.exersices!.count > 0 ? generateSerial() : 0
        
        for oneSet in 1 ..< fieldsOfSet.count+1 {
            let newSet = SetOfExercise(context: viewContext)
            newSet.serial = Int32(oneSet)
            newSet.weight = (fieldsOfSet[oneSet]!["Weight"]) != "" ? Float(fieldsOfSet[oneSet]!["Weight"]!.replacingOccurrences(of: ",", with: "."))! : 0.0
            newSet.reps = fieldsOfSet[oneSet]!["Reps"] != "" ? Int16(fieldsOfSet[oneSet]!["Reps"]!)! : 0
            sets.append(newSet)
        }
        
        newExercise?.sets = NSSet(array: sets)
        newExercise?.inWorkout = inWorkout
        
        dataHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func generateSerial() -> Int32{
        var newSerial = inWorkout.exersices!.count
        (inWorkout.exersices?.allObjects as! [Exercise]).forEach({ ex in
            if ex.serial >= newSerial {
                newSerial = Int(ex.serial+1)
            }
        })
        return Int32(newSerial)
    }
}

//struct CreateNewExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewExerciseView()
//    }
//}
