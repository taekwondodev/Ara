//
//  TranscriptView.swift
//  Deaf
//
//  Created by Davide Galdiero on 25/05/24.
//

import SwiftUI

struct TranscriptView: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    @Environment(AudioRecorder.self) private var audioRecorder: AudioRecorder
    
    @State var audioTranscript: String = ""
    
    @AppStorage("OpenAi") var openAI: Bool = false
    @State private var isActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    @State private var showSettings: Bool = false
    @State private var showOpaqueView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    Image("Ali")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        .edgesIgnoringSafeArea(.top)
                }
                .blur(radius: speechRecognizer.transcript != "" ? 30 : 0)
                
                //MARK: Changes to UI from freelancing start here
                VStack {
                    Spacer()
                    
                    if speechRecognizer.transcript != "" {
                        ScrollView {
                            Spacer(minLength: 180)
                            Text(speechRecognizer.transcript)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    } else {
                        Image("Uccello")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .center)
                            .offset(x: isActive ? UIScreen.main.bounds.width : 0, y: 0)
                            .animation(.easeInOut(duration: 1), value: isActive)
                            .padding()
                        
                        Text(isActive ? "Tap here to stop" : "Tap here to transcribe")
                            .font(.subheadline)
                    }
                    
                    Button(action: {
                        switchRecords(openAI: openAI)
                        isActive.toggle()
                    }) {
                        RecordButton()
                    }
                    .padding()
                } //end of VStack
                .padding()
            }//end of ZStack
            
            //MARK: and end here
            .sensoryFeedback(.success, trigger: isActive)
            .alert("Do you want to save?", isPresented: $showAlert) {
                Button("Don't Save", role: .cancel) {}
                Button("Save", role: .none) { showSheet = true }
            }
            .sheet(isPresented: $showSheet) {
                ModalView(audioTranscript: audioTranscript, showSheet: $showSheet)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gearshape.circle")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView().environmentObject(speechRecognizer)
            }
            .animation(.easeInOut, value: speechRecognizer.transcript)
        }
    }
    
    func switchRecords(openAI: Bool) {
        if !openAI {
            if !isActive {
                speechRecognizer.startTrascribe()
            } else {
                audioTranscript = speechRecognizer.transcript
                speechRecognizer.stopTrascribe()
                showAlert = true
            }
        } else {
            if !isActive {
                audioRecorder.record()
            } else {
                audioRecorder.stopRecording { audioData, fileName in
                    guard let audioData = audioData else {
                        print("Recorded File is unavailable")
                        return
                    }
                    if let fileName = fileName {
                        openAICall(audioTranscript: audioTranscript, audioData: audioData, fileName: fileName)
                    }
                    showAlert = true
                }
            }
        }
    }
    
    func openAICall(audioTranscript: String, audioData: Data, fileName: String) {
        Task {
            do {
                let response = try await OpenAIClassifier.sendPromptToWhisper(audioFile: audioData, fileName: fileName)
                DispatchQueue.main.async {
                    self.speechRecognizer.transcript = response
                }
            } catch {
                print(error)
            }
        }
    }
}
