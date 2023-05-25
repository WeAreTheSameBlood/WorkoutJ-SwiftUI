////
////  PersonView.swift
////  WorkoutJ
////
////  Created by Andrii Hlybchenko on 21.05.2023.
////
//
//import SwiftUI
//import CoreData
//
//struct PersonView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var dataHolder: DataHolder
//    
////    @FetchRequest(sortDescriptors: [])
////    @FetchRequest(entity: Person.entity(), sortDescriptors: [])
////    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Person.weight, ascending: true)])
//    @FetchRequest(entity: Person.entity(), sortDescriptors: [])
//
//    var personsData: FetchedResults<Person>
//    
//    @State var personProps: Person?
//    @State var personName: String = ""
//    @State var personWeight: Float = 0
////    @State var personFatPercent: Float = 0
//
//    @State var editMode: Bool = false
//
//    @State var fields: [String] = ["Weight :", "Fat percent :"]
//    @State var editModes: [String:Bool] = [:]
//
//    @State private var showGeneralInfo: Bool = true
//    @State private var showSizeInfo: Bool = false
//    @State private var showPerfInfo: Bool = false
//    
//    init() {
//        if let firstPerson = personsData.first {
//            personProps = firstPerson
//            personName = firstPerson.name ?? "Error in init"
//            personWeight = firstPerson.weight
//        }
//        _editModes = State(initialValue: Dictionary(uniqueKeysWithValues: fields.map{($0, false)}))
//    }
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                List {
//                    if (personsData.isEmpty) {
//                        VStack {
//                            Text("No persons have been added yet")
//                                .padding(15)
//                                .multilineTextAlignment(.center)
//                            Button("Create new person", action: {createNewPerson()})
//                        }
//                    } else {
//                        Section {
//                            Button(action: {showGeneralInfo = !showGeneralInfo}) {
//                                HStack {
//                                    Image(systemName: "person.crop.rectangle")
//                                    Text("General")
//                                    Spacer()
//                                    Image(systemName: showGeneralInfo ? "chevron.down" : "chevron.right")
//                                }
//                            }
//                            if (showGeneralInfo) {
//                                generalSection()
//                            }
//                        }
//
//                        Section {
//                            Button(action: {showSizeInfo = !showSizeInfo}) {
//                                HStack {
//                                    Image(systemName: "ruler")
//                                    Text("My sizes")
//                                    Spacer()
//                                    Image(systemName: showSizeInfo ? "chevron.down" : "chevron.right")
//                                }
//                            }
//                            if (showSizeInfo) {
////                            sizesSection()
//                            }
//                        }
//
//                        Section {
//                            Button(action: {showPerfInfo = !showPerfInfo}) {
//                                HStack {
//                                    Image(systemName: "dumbbell.fill")
//                                    Text("My performance")
//                                    Spacer()
//                                    Image(systemName: showPerfInfo ? "chevron.down" : "chevron.right")
//                                }
//                            }
//                            if (showPerfInfo) {
////                            performanceSection()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .navigationTitle("My stats")
//    }
//    
//    private func createNewPerson() {
//        let newPerson: Person = Person(context: viewContext)
//        newPerson.name = "My name"
//        newPerson.weight = 0
//        newPerson.fatPercent = 0
//
//        
//        print(personsData.first?.description)
//        try? viewContext.save()
//        print("save?")
//        print(Date().formatted(.dateTime))
//        
////        dataHolder.saveContext(viewContext)
//        
////        do {
////            try viewContext.save()
////        } catch {
////            let nsError = error as NSError
//////            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
////            print("Unresolved error \(nsError), \(nsError.userInfo)")
////            print("error in save()")
////        }
//    }
//    
//    private func saveChanges(editModKey: String) {
//        
//        print(personsData.first?.description)
//        
//        personsData.first?.weight = personWeight
//
//        editModes[editModKey] = false
//
//        dataHolder.saveContext(viewContext)
//        
//        print(personsData.first?.description)
//        print("\nbtn press: \(Date().description)")
//
//    }
//
//    private func generalSection() -> AnyView {
//        return AnyView(
//            Group {
//                HStack {
//                    HStack {
//                        Text(fields[0])
//                        Spacer()
//                    }
//                    HStack {
//                        Group {
//                            editModes[fields[0]]! ? AnyView (
//                                HStack {
//                                    NumberFieldDouble(value: $personWeight)
//                                    Text("kg")
//                                    Spacer()
//
//                                    Button("Save") {saveChanges(editModKey: fields[0])}
//                                        .font(.headline)
//                                }
//                            ) : AnyView (
//                                Group {
//                                    Text("\(personWeight == 0 ? "---" : String(format: "%.1f", personWeight))")
//                                    Text("kg")
//                                    Spacer()
//                                }
//                            )
//                        }
//                        .onTapGesture {
//                            editModes[fields[0]] = true
//                        }
//                    }
//                }
//                HStack {
//                    HStack {
//                        Text(fields[1])
//                        Spacer()
//                    }
//                    HStack{
//                        Group {
//                            editModes[fields[1]]! ? AnyView (
//                                HStack {
////                                    NumberFieldDouble(value: $personFatPercent)
//                                    Text("%")
//                                    Spacer()
//
//                                    Button("Save") {saveChanges(editModKey: fields[1])}
//                                        .font(.headline)
//                                }
//                            ) : AnyView (
//                                Group {
////                                    Text("\(personFatPercent == 0 ? "---" : String(format: "%.1f", personFatPercent))")
//                                    Text("%")
//                                    Spacer()
//                                }
//                            )
//                        }
//                        .onTapGesture {
//                            editModes[fields[1]] = true
//                        }
//                    }
//                }
//            }
//        )
//    }
//
////    private func sizesSection(person: Person) -> AnyView {
////        return AnyView (
////            Group {
////                // Torso
////                Group {
////                    HStack {
////                        HStack{
////                            Text("Neck: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Chest: ")
////                            Spacer()
////                        }
////                        HStack{
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Shoulders: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Right Hand: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Left Hand: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Right Forearm: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Left Forearm: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Waist: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                }
////                // Legs
////                Group {
////                    HStack {
////                        HStack {
////                            Text("Right Leg: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Leg Leg: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Right Gastrocnemius: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                    HStack {
////                        HStack {
////                            Text("Right Gastrocnemius: ")
////                            Spacer()
////                        }
////                        HStack {
////                            Text("-")
////                            Text("cm")
////                            Spacer()
////                        }
////                    }
////                }
////                }
////        )
////    }
////
////    private func performanceSection(person: Person) -> AnyView {
////        return AnyView (
////            Group {
////                HStack {
////                    HStack {
////                        Text("Bench press: ")
////                        Spacer()
////                    }
////                    HStack {
////                        Text("125")
////                        Text("kg")
////                        Spacer()
////                    }
////                }
////                HStack {
////                    HStack {
////                        Text("Deadlift: ")
////                        Spacer()
////                    }
////                    HStack {
////                        Text("200")
////                        Text("kg")
////                        Spacer()
////                    }
////                }
////                HStack {
////                    HStack {
////                        Text("Squad: ")
////                        Spacer()
////                    }
////                    HStack {
////                        Text("180")
////                        Text("kg")
////                        Spacer()
////                    }
////                }
////            }
////        )
////    }
//}
//
//struct PersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonView()
////            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
////            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
//    }
//}
