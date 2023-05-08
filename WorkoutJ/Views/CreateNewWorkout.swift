//
//  CreateNewWorkout.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 30.04.2023.
//

import SwiftUI

struct CreateNewWorkout: View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.completeDate, ascending: true)],
        animation: .default)
    private var workouts: FetchedResults<Workout>
    
    @State var newWorkout: Workout?
    @State var name: String
    @State var desc: String
    @State var createdDate: Date
    @State var onDateBool: Bool
    @State var expectedDate: Date
    
    init() {
        _name = State(initialValue: "")
        _desc = State(initialValue: "")
        _onDateBool = State(initialValue: false)
        _createdDate = State(initialValue: Date())
        _expectedDate = State(initialValue: Date())
    }
    
    var body: some View {
        Form {
            Section(header: Text("New wokout")) {
                TextField("Name", text: $name)
                TextField("Description (optional)", text: $desc)
            }
            Section(header: Text("Expected date")) {
                Toggle("Schedule a date", isOn: $onDateBool)
                if onDateBool == true {
                    withAnimation() {
                        DatePicker("On date",
                                   selection: $expectedDate, displayedComponents: [.date])
                    }
                }
            }
            Section {
                Button("Save", action: saveNewItem)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func saveNewItem() {
        newWorkout = Workout(context: viewContext)
        newWorkout?.serial = Int32(workouts.count)
        newWorkout?.name = name != "" ? name : "Name is empty"
        newWorkout?.desc = desc
        newWorkout?.createdDate = Date()
        newWorkout?.isComplete = false
        newWorkout?.onDateBool = onDateBool
        newWorkout?.expectedDate = expectedDate
        
        dataHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct CreateNewWorkout_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewWorkout()
    }
}
