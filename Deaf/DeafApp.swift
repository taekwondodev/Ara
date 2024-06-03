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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: AudioRecord.self)
    }
}
