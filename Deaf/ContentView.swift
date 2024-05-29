//
//  ContentView.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: SPEECH
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    //MARK: View Property
    init(){
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    @State var isOnboarding = true
    var body: some View {
        if isOnboarding {
            OnBoardingView(isOnboarded: $isOnboarding)
        }
        else {
            TabView{
                SavedRecords()
                    .environmentObject(speechRecognizer)
                    .tabItem { Label("Records", systemImage: "list.clipboard.fill") }
                TranscriptView()
                    .environmentObject(speechRecognizer)
                    .tabItem { Label("Play", systemImage: "play.fill") }
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
