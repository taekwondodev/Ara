//
//  DeafApp.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import SwiftUI

@main
struct DeafApp: App {
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(speechRecognizer)
        }
    }
}
