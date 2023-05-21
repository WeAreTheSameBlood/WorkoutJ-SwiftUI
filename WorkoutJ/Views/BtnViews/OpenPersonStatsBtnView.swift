//
//  OpenPersonStatsBtnView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 21.05.2023.
//

import SwiftUI

struct OpenPersonStatsBtnView: View {
    
    var body: some View {
        HStack{
            NavigationLink(destination: PersonView()) {
                Image(systemName: "person")
                    .imageScale(.large)
            }
            .padding(5)
            .cornerRadius(45)
        }
    }
}

struct OpenPersonStatsBtnView_Previews: PreviewProvider {
    static var previews: some View {
        OpenPersonStatsBtnView()
    }
}
