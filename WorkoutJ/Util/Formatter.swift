//
//  Formatters.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 11.05.2023.
//

import SwiftUI

public func dateToStr(date: Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.string(from: date)
}
