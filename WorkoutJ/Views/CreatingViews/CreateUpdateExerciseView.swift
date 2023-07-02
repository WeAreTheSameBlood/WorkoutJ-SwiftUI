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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseCategory.name, ascending: true)])
    var categories: FetchedResults<ExerciseCategory>

    @State var newExercise: Exercise?
    @State var name: String
    @State var desc: String
    @State var category: ExerciseCategory?
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
        _category = State(initialValue: nil)
        _weightArr = State(initialValue: [""])
        _repsArr = State(initialValue: [""])
    }
    
    init(exercise: Exercise) {
        _newExercise = State(initialValue: exercise)
        _name = State(initialValue: exercise.name!)
        _desc = State(initialValue: exercise.desc!)
        _category = State(initialValue: exercise.category ?? nil)
        _sets = State(initialValue: exercise.sets?.allObjects as! [SetOfExercise])
        _inWorkout = State(initialValue: exercise.inWorkout!)
        _numOfFields = State(initialValue: exercise.sets!.count)
        
        _weightArr = State(initialValue: Array(sets.sorted(by: {$0.serial < $1.serial}).map{String($0.weight)}))
        _repsArr = State(initialValue: Array(sets.sorted(by: {$0.serial < $1.serial}).map{String($0.reps)}))
        
    }
    
    var body: some View {
        Form {
            Group {
                Section(header: Text(newExercise == nil ? "New exercise" : "Changing exercise")) {
                    TextField("Name", text: $name)
                    TextField("Description (optional)", text: $desc)
                }
                
                Section(header: Text("Choose category")) {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.flexible())]) {
                            ForEach(categories) { oneCategory in
                                OneCategoryView(category: oneCategory)
                                    .onTapGesture {
                                        category = oneCategory
                                    }
                            }
                        }
                    }
                    HStack{
                        Text("Selected:")
                        (category == nil
                         ? Text(categories.first!.name!).foregroundColor(Color(categories.first!.color as! UIColor))
                         : Text(category!.name!).foregroundColor(Color(category?.color as! UIColor))
                        )
                        Spacer()
                    }
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
                            Button(role: .destructive) { deleteOneFieldOfSet(numOfSet: numOfSet) } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                        
                    }
                }
                .id(numOfFields)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            Section {
                Button("Add Set Field", action: addFieldOfSet)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            Section {
                Button("Save", action: saveNewExercise)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func deleteOneFieldOfSet(numOfSet: Int) {
        weightArr.remove(at: numOfSet)
        repsArr.remove(at: numOfSet)
        
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
            newExercise?.serial = inWorkout.exercises!.count > 0 ? generateSerial() : 0
        }
        
        newExercise?.name = name != "" ? name : "Name is empty"
        newExercise?.desc = desc
        
        if (category == nil) { category = categories.first}
        category?.addToExercise(newExercise!)
        
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
        return (inWorkout.exercises?.allObjects as! [Exercise]).max(by: {$0.serial < $1.serial})!.serial + 1
    }
}

//struct CreateNewExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewExerciseView()
//    }
//}
