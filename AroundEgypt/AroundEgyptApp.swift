//
//  AroundEgyptApp.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import SwiftUI

@main
struct AroundEgyptApp: App {
    let persistenceController = PersistenceController.shared

     var body: some Scene {
        WindowGroup {
           
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
