//
//  TranscriptView.swift
//  Deaf
//
//  Created by Davide Galdiero on 25/05/24.
//

import SwiftUI

struct TranscriptView: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    @EnvironmentObject var liveActivityManager: SetLiveActivity
    
    @State var audioTranscript: String = ""
    
    @AppStorage("OpenAi") var openAI: Bool = false  //pro property
    @State private var isActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    @State private var showSettings: Bool = false
    
    //MARK: Now the transcript is a group of words joined after splitting them, so that they can each be postprocessed
    var formattedTranscript: some View {
        let words = speechRecognizer.transcript.split(separator: " ")
        let lastWord = words.last ?? ""
        
        return Group {
            Text(words.dropLast().joined(separator: " "))
                .fontWeight(.semibold)
            Text(lastWord)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color(red: 0, green: 0.78, blue: 0.75))
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    Image("Ali")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.size.height, alignment: .top)
                        .edgesIgnoringSafeArea(.top)
                        .opacity(isActive ? 0.6 : 1.0)
                        .blur(radius: isActive ? 15.0 : 0.0)
                }
                .accessibilityHidden(true)
                
                //MARK: Changes to UI from freelancer start here
                VStack {
                    Spacer()
                    
                    if speechRecognizer.transcript != "" {
                        ScrollView {
                            Spacer(minLength: 250)
                            formattedTranscript
                                .padding(.horizontal)
                        }
                    } else {
                        Image("Uccello")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .center)
                            .offset(x: isActive ? UIScreen.main.bounds.width : 0, y: 0)
                            .animation(.easeInOut(duration: 1), value: isActive)
                            .padding()
                            .accessibilityHidden(true)
                    }
                    
                    if isActive {
                        Caricamento()
                            .accessibilityHidden(true)
                    }
                    else {
                        Text("Tap here to transcribe")
                            .font(.subheadline)
                    }
                    Button(action: {
                        recordingAction()
                        isActive.toggle()
                    }) {
                        RecordButton(active: isActive)
                    }
                    .accessibilityLabel("Record")
                } //END VStack
            }//END ZStack
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
                    }.accessibilityLabel("Settings")
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView().environmentObject(speechRecognizer)
            }
            .animation(.easeInOut, value: speechRecognizer.transcript)
        }
    }
    
    func recordingAction() {
        if !isActive {
            speechRecognizer.startTrascribe()
            liveActivityManager.setupActivity()
        } else {
            audioTranscript = speechRecognizer.transcript
            speechRecognizer.stopTrascribe()
            liveActivityManager.endActivity()
            showAlert = true
        }
    }
}
