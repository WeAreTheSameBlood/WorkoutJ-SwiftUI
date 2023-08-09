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
    
    @State var navigationTitle: String

    @State var newExercise: Exercise?
    @State var name: String
    @State var desc: String
    @State var category: ExerciseCategory?
    @State var textToExercise: String
    @State var cardioTimer: Int
    @State var planeTime: Bool = true
    @State var sets: [SetOfExercise]
    @State var inWorkout: Workout
    
    @State var numOfFields: Int
    @State var fieldsOfSet: [Int : [String:String]] = [:]
    @State var weightArr : [String] = []
    @State var repsArr : [String] = []
    
    @State private var selectedTime = Date()
    
    init(inWorkout: Workout) {
        _navigationTitle = State(initialValue: "New Exercise")
        _name = State(initialValue: "")
        _desc = State(initialValue: "")
        _textToExercise = State(initialValue: "")
        _cardioTimer = State(initialValue: 5)
        _sets = State(initialValue: [])
        _inWorkout = State(initialValue: inWorkout)
        _numOfFields = State(initialValue: 1)
        _weightArr = State(initialValue: [""])
        _repsArr = State(initialValue: [""])
    }
    
    init(exercise: Exercise) {
        _navigationTitle = State(initialValue: "Changing Exercise")
        _newExercise = State(initialValue: exercise)
        _name = State(initialValue: exercise.name!)
        _desc = State(initialValue: exercise.desc!)
        _category = State(initialValue: exercise.category ?? nil)
        _textToExercise = State(initialValue: exercise.textToExercise ?? "")
        _cardioTimer = State(initialValue: Int(exercise.cardioTimer))
        _sets = State(initialValue: exercise.sets?.allObjects as! [SetOfExercise])
        _inWorkout = State(initialValue: exercise.inWorkout!)
        _numOfFields = State(initialValue: exercise.sets!.count)
        _weightArr = State(initialValue: Array(sets.sorted(by: {$0.serial < $1.serial}).map{String($0.weight)}))
        _repsArr = State(initialValue: Array(sets.sorted(by: {$0.serial < $1.serial}).map{String($0.reps)}))
    }
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Main Information")) {
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
                        if category != nil { Text(category?.name ?? "Error categ").foregroundColor(Color(category?.color as! UIColor)) }
                        Spacer()
                    }
                }
                
                if category != nil {
                    switch category?.name {
                    case "Basic":
                        getBasicSection()
                    case "Cardio":
                        getCardioSection()
                    case "Stretching":
                        getStretchingSection()
                    default:
                        getWarmUpHangUpSection()
                    }
                }
            }
//            .onTapGesture {
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//            }
            
            Section {
                Button("Save", action: saveNewExercise)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle(navigationTitle)
        .onAppear {
            guard category == nil else { return }
            if let firstCategory = categories.first {
                    self.category = firstCategory
            }
        }
    }
    
    private func getBasicSection() -> AnyView {
        return AnyView(
            Group {
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

                Section {
                    Button("Add Set Field", action: addFieldOfSet)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            })
    }
    
    private func getCardioSection() -> AnyView {
        return AnyView(
            Section(header: Text("Parameters on cardio")) {
                VStack {
                    Toggle("Plan of the time", isOn: $planeTime)
                    if planeTime {
                        HStack {
                            Text("Time of duration")
                            Spacer()
                            Picker("", selection: $cardioTimer) {
                                ForEach(0..<61) { minute in
                                    Text("\(minute) min")
                                }
                            }
                            .frame(width: 120)
                            .clipped()
                            .pickerStyle(WheelPickerStyle())
                            Spacer()
                        }
                    }
                }
            }
        )
    }
    
    private func getWarmUpHangUpSection() -> AnyView {
        return AnyView(
            Section(header: Text("Parameters of Warm-up and Hang-up")) {
                Text("Warm-up and Hang-up")
            }
        )
    }
    
    private func getStretchingSection() -> AnyView {
        return AnyView(
            Section(header: Text("Description for stretching")) {
                TextField("Text block", text: $textToExercise)
            }
        )
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
        
        if (newExercise == nil) {
            newExercise = Exercise(context: viewContext)
            newExercise?.serial = inWorkout.exercises!.count > 0 ? generateSerial() : 0
        }
        
        newExercise?.name = name != "" ? name : "Name is empty"
        newExercise?.desc = desc
        category?.addToExercise(newExercise!)
        
        if (category!.name == "Basic") {
            
            saveSetsFromFields()
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
        } else if (category!.name == "Cardio") {
            newExercise?.cardioTimer = Int32(cardioTimer)
        } else {
            newExercise?.textToExercise = textToExercise
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
