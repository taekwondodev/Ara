//
//  ContentView.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    //MARK: SPEECH
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    
    //MARK: PiP
    //@StateObject private var viewModel = AVPlayerViewModel()
    
    //MARK: VIEW PROPERTY
    @State private var isActive = false
    var body: some View {
        VStack {
            TranscriptView()
                .environmentObject(speechRecognizer)
            
            //VideoPlayerView(viewModel: viewModel)
            
            //TODO: PASS A URL TO VIEWMODEL OF THE STREAM
            Button(action: {
                if !isActive{
                    speechRecognizer.startTrascribe()
                    //viewModel.media = Media(url: <#T##URL#>)
                }
                else {
                    speechRecognizer.stopTrascribe()
                    //viewModel.pause()
                }
                isActive.toggle()
            }) {  //LABEL
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .tint(isActive ? .red : .blue)
                    Text(isActive ? "Stop" : "Start")
                        .foregroundStyle(.black)
                        .bold()
                }
            }
            
        } //END VSTACK
    }
    
}

#Preview {
    ContentView()
}
