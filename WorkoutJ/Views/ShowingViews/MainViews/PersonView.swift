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
    
    @FetchRequest(entity: Person.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(value: true))
    var personsData: FetchedResults<Person>
    
    var body: some View {
        
        @State var personProps: Person = personsData.first!
        
        NavigationView {
            ZStack {
                VStack {
                    List {
                        Section(header: Text("General")) {
                            HStack {
                                HStack {
                                    Text("Weight: ")
                                    Spacer()
                                }
                                HStack {
                                    Text("\(String(format: "%.1f", personProps.weight))")
                                    Text("kg")
                                    Spacer()
                                }
                            }
                            HStack {
                                HStack {
                                    Text("Percent of fat: ")
                                    Spacer()
                                }
                                HStack {
                                    Text("\(String(format: "%.1f", personProps.fatPercent))")
                                    Text("%")
                                    Spacer()
                                }
                            }
                        }
                        Section(header: Text("My sizes")) {
                            HStack {
                                HStack{
                                    Text("Chest: ")
                                    Spacer()
                                }
                                HStack {
                                    Text("110")
                                    Text("cm")
                                    Spacer()
                                }
                            }
                            HStack {
                                HStack {
                                    Text("Back: ")
                                    Spacer()
                                }
                                HStack{
                                    Text("125")
                                    Text("cm")
                                    Spacer()
                                }
                            }
                            HStack {
                                HStack {
                                    Text("Legs: ")
                                    Spacer()
                                }
                                HStack {
                                    Text("75")
                                    Text("cm")
                                    Spacer()
                                }
                            }
                        }
                        Section(header: Text("My performance")) {
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
                                    Text("180")
                                    Text("kg")
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("My info (in develop)")
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
    }
}
