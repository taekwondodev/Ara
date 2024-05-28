//
//  ContentView.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //MARK: SPEECH
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    //MARK: PiP
    //@StateObject private var viewModel = AVPlayerViewModel()
    
    var body: some View {
        TabView{
            TranscriptView()
                .environmentObject(speechRecognizer)
                .tabItem { Label("Play", systemImage: "play.fill") }
            SavedRecords()
                .environmentObject(speechRecognizer)
                .tabItem { Label("Records", systemImage: "list.clipboard.fill") }
            SettingsView()
                .environmentObject(speechRecognizer)
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
    
}

#Preview {
    ContentView()
}
