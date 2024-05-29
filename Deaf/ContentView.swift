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
    
    //MARK: View Property
    @State var isOnboarding = true
    var body: some View {
        if isOnboarding {
            OnBoardingView(isOnboarded: $isOnboarding)
        }
        else {
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
    
}

#Preview {
    ContentView()
}
