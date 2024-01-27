//
//  Constants.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 27/01/24.
//

import Foundation
import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

var backgroungGradient: LinearGradient {
    return LinearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}
