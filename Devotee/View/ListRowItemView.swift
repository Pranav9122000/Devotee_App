//
//  ListRowItemView.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 27/01/24.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded, weight: .heavy))
                .foregroundStyle(item.completion ? .pink : .primary)
                .padding(.vertical, 12)
                .animation(.default)
        }
        .toggleStyle(CheckboxStyleView())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
    }
}
