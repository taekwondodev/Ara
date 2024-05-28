//
//  DeafApp.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import SwiftUI
import SwiftData

@main
struct DeafApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: AudioRecord.self, Category.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
