//
//  DevoteeApp.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 21/01/24.
//

import SwiftUI

@main
struct DevoteeApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
