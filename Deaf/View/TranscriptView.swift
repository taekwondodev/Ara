//
//  TranscriptView.swift
//  Deaf
//
//  Created by Davide Galdiero on 25/05/24.
//

import SwiftUI

struct TranscriptView: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    @Environment(AudioRecord.self) private var audioRecorder
    
    @State var audioTranscript: String = ""
    @State var audioTitle: String = ""
    
    @AppStorage("OpenAi") var openAI: Bool = false
    @State private var isActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    var body: some View {
        VStack{
            GeometryReader{  geometry in
                Image("Ali")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                    .edgesIgnoringSafeArea(.top)
            }
            
            if (speechRecognizer.transcript != ""){
                Text(speechRecognizer.transcript)
                    .frame(maxHeight: 200, alignment: .center)
                    .padding()
            }
            Image("Uccello")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150, alignment: .center)
                .offset(x: isActive ? UIScreen.main.bounds.width : 0, y: 0)
                .animation(.easeInOut(duration: 1), value: isActive)
                .padding()
            
            Text(isActive ? "Tap Here to stop" : "Tap Here to transcribe")
                .font(.subheadline)
            Button(action: {
                if !isActive{
                    speechRecognizer.startTrascribe()
                }
                else {
                    audioTranscript = speechRecognizer.transcript
                    speechRecognizer.stopTrascribe()
                    showAlert = true
                }
                isActive.toggle()
            })
            { //LABEL
                RecordButton()
            }
        }// END ZSTACK
        .alert("Do you want to save?", isPresented: $showAlert) {
            Button("Dont Save", role: .cancel) {}
            Button("Save", role: .none) { showSheet = true }
        }
        .sheet(isPresented: $showSheet, content: {
            ModalView(audioTranscript: audioTranscript, audioTitle: $audioTitle)
        })
        .animation(.easeInOut, value: speechRecognizer.transcript)
    }
    
    func switchRecords(openAI: Bool){
        ///se openAI attivo fai le opzioni di openAI altrimenti usi Speech
    }
}
