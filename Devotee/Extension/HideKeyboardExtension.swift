//
//  HideKeyboardExtension.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 27/01/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
