//
//  OneSetView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 11.05.2023.
//

import SwiftUI

struct OneSetView: View {
    
    @ObservedObject var oneSet: SetOfExercise
    
    var body: some View {
        VStack(spacing: 0) {
            oneSet.weight.truncatingRemainder(dividingBy: 1) == 0
            ? Text("\(String(format: "%.0f", oneSet.weight))").padding(7)
            : Text("\(String(format: "%.1f", oneSet.weight))").padding(7)
            Divider()
            Text("x\(oneSet.reps.description)").padding(7)
        }
        .listStyle(InsetListStyle())
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        
    }
}

//struct OneSetView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneSetView()
//    }
//}
