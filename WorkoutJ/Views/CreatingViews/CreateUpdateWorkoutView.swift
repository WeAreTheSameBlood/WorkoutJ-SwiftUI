//
//  CreateNewWorkout.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI

struct CreateUpdateWorkoutView: View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.completeDate, ascending: true)])
    private var workouts: FetchedResults<Workout>
    
    @State var navigationTitle: String
    
    @State var newWorkout: Workout?
    @State var name: String
    @State var desc: String
    @State var createdDate: Date
    @State var onDateBool: Bool
    @State var expectedDate: Date
    @State var isComplete: Bool
    @State var completedDate: Date
    
    init() {
        _navigationTitle = State(initialValue: "New Workout")
        _name = State(initialValue: "")
        _desc = State(initialValue: "")
        _onDateBool = State(initialValue: false)
        _createdDate = State(initialValue: Date())
        _expectedDate = State(initialValue: Date())
        _isComplete = State(initialValue: false)
        _completedDate = State(initialValue: Date())
    }
    
    init(workout: Workout) {
        _navigationTitle = State(initialValue: "Changing Exercise")
        _newWorkout = State(initialValue: workout)
        _name = State(initialValue: workout.name!)
        _desc = State(initialValue: workout.desc!)
        _onDateBool = State(initialValue: workout.onDateBool)
        _createdDate = State(initialValue: workout.createdDate!)
        _expectedDate = State(initialValue: workout.expectedDate ?? Date())
        _isComplete = State(initialValue: workout.isComplete)
        _completedDate = State(initialValue: workout.completeDate ?? Date())
    }
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Main Information")) {
                    TextField("Name", text: $name)
                    TextField("Description (optional)", text: $desc)
                }
                Section(header: Text("Expected date")) {
                    Toggle("Schedule a date", isOn: $onDateBool)
                    if onDateBool == true {
                        withAnimation() {
                            DatePicker("On date",
                                       selection: $expectedDate,
                                       displayedComponents: [.date])
                        }
                    }
                }
                if (newWorkout?.isComplete == true) {
                    Section(header: Text("Completed date")) {
                        Toggle("Complete status", isOn: $isComplete)
                        if isComplete {
                            DatePicker("Completed date",
                                       selection: $completedDate,
                                       displayedComponents: [.date])
                        }
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            Section {
                Button("Save", action: saveNewItem)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }.navigationTitle(navigationTitle)
    }
    
    private func saveNewItem() {
        if (newWorkout == nil) {
            newWorkout = Workout(context: viewContext)
            newWorkout?.createdDate = createdDate
            newWorkout?.serial = workouts.isEmpty ? 0 : createNewWorkoutSerial()
            newWorkout?.isComplete = false
        }
        newWorkout?.name = name != "" ? name : "Name is empty"
        newWorkout?.desc = desc
        newWorkout?.onDateBool = onDateBool
        newWorkout?.expectedDate = expectedDate
        
        newWorkout?.isComplete = isComplete
        if ((newWorkout?.isComplete ?? false) && completedDate <= Date()) {
            newWorkout?.completeDate = completedDate
        }
        
        dataHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    public func createNewWorkoutSerial() -> Int32 {
        return (workouts.max(by: {$0.serial < $1.serial})!.serial + 1)
    }
}

struct CreateNewWorkout_Previews: PreviewProvider {
    static var previews: some View {
        CreateUpdateWorkoutView()
    }
}
