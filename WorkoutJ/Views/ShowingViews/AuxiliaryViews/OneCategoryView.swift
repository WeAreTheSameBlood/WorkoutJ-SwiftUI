//
//  OneCategoryView.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 28.06.2023.
//

import SwiftUI

struct OneCategoryView: View {
    @ObservedObject var category: ExerciseCategory
    
    var body: some View {
        VStack(spacing: 1) {
            Image(systemName: category.nameImage ?? "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text(category.name ?? "Error categ")
                .font(.caption)
                .foregroundColor(.primary)
                .padding(.horizontal, 8)
        }
        .frame(minWidth: 60, maxWidth: 120, minHeight: 50, maxHeight: 50)
        .background(Color(category.color as! UIColor).opacity(0.25))
        .cornerRadius(12)
    }
}

//struct OneCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneCategoryView()
//    }
//}
