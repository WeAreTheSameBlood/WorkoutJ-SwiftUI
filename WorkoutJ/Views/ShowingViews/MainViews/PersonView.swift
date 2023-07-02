//
//  PersonView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 21.05.2023.
//

import SwiftUI
import CoreData

struct PersonView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    @FetchRequest(entity: Person.entity(), sortDescriptors: [])
    var personsData: FetchedResults<Person>
    
    @State var personProps: Person?
    @State var personName: String = ""
    @State var personWeight: Float = 0
//    @State var personFatPercent: Float = 0

    @State var editMode: Bool = false

    @State var fields: [String] = ["Weight :", "Fat percent :"]
    @State var editModes: [String:Bool] = [:]

    @State private var showGeneralInfo: Bool = true
    @State private var showSizeInfo: Bool = false
    @State private var showPerfInfo: Bool = false
    
    init() {
//        if !personsData.isEmpty {
        _personProps = State(initialValue: personsData.first)
        _personWeight = State(initialValue: personsData.first?.weight ?? 44.4)
//        } else {
//            createNewPerson()
//            _personProps = State(initialValue: personsData.first)
//        }
        _editModes = State(initialValue: Dictionary(uniqueKeysWithValues: fields.map{($0, false)}))
    }
    
    var body: some View {
        if personsData.isEmpty {
            VStack {
                Text("No person have been added yet")
                Button(action: { createNewPerson() }) {
                    HStack {
                        Text("Create new Person page")
                    }
                }
                .padding(15)
                .background(.blue.opacity(0.5))
                .tint(.white)
                .cornerRadius(20)
            }
        } else {
            
            ZStack {
                VStack {
                    List {
                        Section {
                            Button(action: {showGeneralInfo = !showGeneralInfo}) {
                                HStack {
                                    Image(systemName: "person.crop.rectangle")
                                    Text("General + count: \(personsData.count)")
                                    Spacer()
                                    Image(systemName: showGeneralInfo ? "chevron.down" : "chevron.right")
                                }
                            }
                            if (showGeneralInfo) {
                                generalSection()
                            }
                        }
                        
                        Section {
                            Button(action: {showSizeInfo = !showSizeInfo}) {
                                HStack {
                                    Image(systemName: "ruler")
                                    Text("My sizes")
                                    Spacer()
                                    Image(systemName: showSizeInfo ? "chevron.down" : "chevron.right")
                                }
                            }
                            if (showSizeInfo) {
                            sizesSection()
                            }
                        }
                        
                        Section {
                            Button(action: {showPerfInfo = !showPerfInfo}) {
                                HStack {
                                    Image(systemName: "dumbbell.fill")
                                    Text("My performance")
                                    Spacer()
                                    Image(systemName: showPerfInfo ? "chevron.down" : "chevron.right")
                                }
                            }
                            if (showPerfInfo) {
                            performanceSection()
                            }
                        }
                    
                    }
                }
            }
            .navigationTitle("My stats")
        }
    }
    
    private func createNewPerson() {
        withAnimation {
            let newPerson: Person = Person(context: viewContext)
            newPerson.serial = personsData.isEmpty ? Int16(0) : createNewSerial()
            newPerson.name = "My name"
            newPerson.weight = Float(personsData.count)
            newPerson.fatPercent = Float(personsData.count)
        }

        dataHolder.saveContext(viewContext)
    }
    
    private func createNewSerial() -> Int16 {
        return (personsData.max(by: {$0.serial < $1.serial})!.serial + 1)
    }
    
    private func deleteNewPerson() {
        withAnimation {
            viewContext.delete(personsData.first!)
        }

        dataHolder.saveContext(viewContext)
    }
    
    private func saveChanges(editModKey: String) {

        personsData.first?.weight = personWeight

        editModes[editModKey] = false

        dataHolder.saveContext(viewContext)

    }

    private func generalSection() -> AnyView {
        return AnyView(
            Group {
                HStack {
                    HStack {
                        Text(fields[0])
                        Spacer()
                    }
                    HStack {
                        Group {
                            editModes[fields[0]]! ? AnyView (
                                HStack {
                                    NumberFieldFloat(value: $personWeight)
                                    Text("kg")
                                    Spacer()

                                    Button("Save") {saveChanges(editModKey: fields[0])}
                                        .font(.headline)
                                }
                            ) : AnyView (
                                Group {
                                    Text("\(personWeight == 0 ? "---" : String(format: "%.1f", personWeight))")
                                    Text("kg")
                                    Spacer()
                                }
                            )
                        }
                        .onTapGesture {
                            editModes[fields[0]] = true
                        }
                    }
                }
                HStack {
                    HStack {
                        Text(fields[1])
                        Spacer()
                    }
                    HStack{
                        Group {
                            editModes[fields[1]]! ? AnyView (
                                HStack {
//                                    NumberFieldDouble(value: $personFatPercent)
                                    Text("%")
                                    Spacer()

                                    Button("Save") {saveChanges(editModKey: fields[1])}
                                        .font(.headline)
                                }
                            ) : AnyView (
                                Group {
//                                    Text("\(personFatPercent == 0 ? "---" : String(format: "%.1f", personFatPercent))")
                                    Text("%")
                                    Spacer()
                                }
                            )
                        }
                        .onTapGesture {
                            editModes[fields[1]] = true
                        }
                    }
                }
            }
        )
    }

    private func sizesSection() -> AnyView {
        return AnyView (
            Group {
                // Torso
                Group {
                    HStack {
                        HStack{
                            Text("Neck: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Chest: ")
                            Spacer()
                        }
                        HStack{
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Shoulders: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Right Hand: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Left Hand: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Right Forearm: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Left Forearm: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Waist: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                }
                // Legs
                Group {
                    HStack {
                        HStack {
                            Text("Right Leg: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Leg Leg: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Right Gastrocnemius: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                    HStack {
                        HStack {
                            Text("Right Gastrocnemius: ")
                            Spacer()
                        }
                        HStack {
                            Text("-")
                            Text("cm")
                            Spacer()
                        }
                    }
                }
                }
        )
    }

    private func performanceSection() -> AnyView {
        return AnyView (
            Group {
                HStack {
                    HStack {
                        Text("Bench press: ")
                        Spacer()
                    }
                    HStack {
                        Text("125")
                        Text("kg")
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Text("Deadlift: ")
                        Spacer()
                    }
                    HStack {
                        Text("200")
                        Text("kg")
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Text("Squad: ")
                        Spacer()
                    }
                    HStack {
                        Text("190")
                        Text("kg")
                        Spacer()
                    }
                }
            }
        )
    }
}

struct PersonView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    static var previews: some View {
        PersonView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
    }
}
