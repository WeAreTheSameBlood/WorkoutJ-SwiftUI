//
//  CreateNewExerciseView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 01.05.2023.
//

import SwiftUI

struct CreateUpdateExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder

    @State var newExercise: Exercise?
    @State var name: String
    @State var desc: String
    @State var sets: [SetOfExercise]
    @State var inWorkout: Workout
    
    @State var numOfFields: Int
    
    @State var fieldsOfSet: [Int : [String:String]] = [:]
    
    @State var weightArr : [String] = []
    @State var repsArr : [String] = []
    
    init(inWorkout: Workout) {
        _name = State(initialValue: "")
        _desc = State(initialValue: "")
        _sets = State(initialValue: [])
        _inWorkout = State(initialValue: inWorkout)
        _numOfFields = State(initialValue: 1)
        
        _weightArr = State(initialValue: [""])
        _repsArr = State(initialValue: [""])
    }
    
    init(exercise: Exercise) {
        _newExercise = State(initialValue: exercise)
        _name = State(initialValue: exercise.name!)
        _desc = State(initialValue: exercise.desc!)
        _sets = State(initialValue: exercise.sets?.allObjects as! [SetOfExercise])
        _inWorkout = State(initialValue: exercise.inWorkout!)
        _numOfFields = State(initialValue: exercise.sets!.count)
        
        _weightArr = State(initialValue: Array(sets.sorted(by: {$0.serial < $1.serial}).map{String($0.weight)}))
        _repsArr = State(initialValue: Array(sets.sorted(by: {$0.serial < $1.serial}).map{String($0.reps)}))
        
    }
    
    var body: some View {
        
        Form {
            Section(header: Text(newExercise == nil ? "New exercise" : "Changing exercise")) {
                TextField("Name", text: $name)
                TextField("Description (optional)", text: $desc)
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
                    .swipeActions(edge: .trailing) {

                        // Delete one field of sets
                        Button(role: .destructive) { deleteOneFieldOdSet(numOfSet: numOfSet) } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
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
    
    private func deleteOneFieldOdSet(numOfSet: Int) {
        weightArr = weightArr.filter{$0 != weightArr[numOfSet]}
        repsArr = repsArr.filter{$0 != repsArr[numOfSet]}
        
        numOfFields -= 1
    }
    
    private func addFieldOfSet() {
        saveSetsFromFields()
        numOfFields += 1
        weightArr = Array(weightArr) + [""]
        repsArr = Array(repsArr) + [""]
    }
    
    private func saveSetsFromFields() {
        for num in 0 ..< numOfFields {
            var setsField: [String : String] = [:]
            setsField["Weight"] = weightArr[num]
            setsField["Reps"] = repsArr[num]
            fieldsOfSet[num+1] = setsField
        }
    }

    private func saveNewExercise() {
        saveSetsFromFields()
        
        if (newExercise == nil) {
            newExercise = Exercise(context: viewContext)
            newExercise?.serial = inWorkout.exersices!.count > 0 ? generateSerial() : 0
        }
        
        
        newExercise?.name = name != "" ? name : "Name is empty"
        newExercise?.desc = desc
//        newExercise?.serial = inWorkout.exersices!.count > 0 ? generateSerial() : 0
        
        if (!sets.isEmpty) {
            newExercise?.sets = NSSet(array: [])
        }
        
        for oneSet in 1 ..< fieldsOfSet.count+1 {
            let newSet = SetOfExercise(context: viewContext)
            newSet.serial = Int32(oneSet)
            newSet.weight = (fieldsOfSet[oneSet]!["Weight"]) != "" ? Float(fieldsOfSet[oneSet]!["Weight"]!.replacingOccurrences(of: ",", with: "."))! : 0.0
            newSet.reps = fieldsOfSet[oneSet]!["Reps"] != "" ? Int16(fieldsOfSet[oneSet]!["Reps"]!)! : 0
            newExercise?.addToSets(newSet)
        }
        
        newExercise?.inWorkout = inWorkout
        
        dataHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func generateSerial() -> Int32{
//        var newSerial = inWorkout.exersices!.count
//        (inWorkout.exersices?.allObjects as! [Exercise]).forEach({ ex in
//            if ex.serial >= newSerial {
//                newSerial = Int(ex.serial+1)
//            }
//        })
//        return Int32(newSerial)
        return (inWorkout.exersices?.allObjects as! [Exercise]).max(by: {$0.serial < $1.serial})!.serial + 1
    }
}

//struct CreateNewExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewExerciseView()
//    }
//}
