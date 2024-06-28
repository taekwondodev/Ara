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
    @StateObject var liveActivityManager = SetLiveActivity()
    
    //MARK: View Property
    init(){
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    @AppStorage("isOnboarding") var isOnboarding = true
    
    var body: some View {
        if isOnboarding {
            OnBoardingView()
        }
        else {
            TabView{
                TranscriptView()
                    .environmentObject(speechRecognizer)
                    .environmentObject(liveActivityManager)
                    .tabItem { Label("Record", systemImage: "waveform.circle") }
                
                SavedRecords()
                    .environmentObject(speechRecognizer)
                    .tabItem { Label("Library", systemImage: "book.circle") }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
