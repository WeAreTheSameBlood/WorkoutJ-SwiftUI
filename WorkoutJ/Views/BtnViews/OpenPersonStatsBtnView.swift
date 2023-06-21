//
//  OpenPersonStatsBtnView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 21.05.2023.
//

import SwiftUI

struct OpenPersonStatsBtnView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: PersonView()
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(dataHolder)
            ){
                Image(systemName: "person")
                    .imageScale(.large)
            }
            .padding(5)
            .cornerRadius(45)
        }
    }
}

struct OpenPersonStatsBtnView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    static var previews: some View {
        OpenPersonStatsBtnView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataHolder(PersistenceController.shared.container.viewContext))
    }
}
