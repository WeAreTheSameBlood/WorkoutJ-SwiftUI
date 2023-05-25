//
//  NumberFields.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 24.05.2023.
//

import SwiftUI
import Combine

struct NumberFieldsInt: View {
    @Binding var value: Int
    @State private var inputValue: String = ""

    var body: some View {
        TextField(value.description, text: $inputValue)
            .fixedSize(horizontal: true, vertical: false)
            .keyboardType(.numberPad)
            .onReceive(Just(inputValue)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.inputValue = filtered
                }
                if let value = Int(filtered) {
                    self.value = value
                }
            }
    }
}

struct NumberFieldFloat: View {
    @Binding var value: Float
    @State private var inputValue: String = ""

    var body: some View {
        TextField(value.description, text: $inputValue)
            .fixedSize(horizontal: true, vertical: false)
            .keyboardType(.decimalPad)
            .onReceive(Just(inputValue)) { newValue in
                let filtered = newValue.filter { "0123456789.".contains($0) }
                if filtered != newValue {
                    self.inputValue = filtered
                }
                if let value = Float(filtered) {
                    self.value = value
                }
            }
    }
}


//struct NumberFieldDouble_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberFieldDouble()
//    }
//}
