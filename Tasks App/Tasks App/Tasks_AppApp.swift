//
//  Tasks_AppApp.swift
//  Tasks App
//
//  Created by Даниил Храповицкий on 28.09.2020.
//

import SwiftUI

@main
struct Tasks_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
