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
    var body: some View {
        NavigationStack{
            VStack{
                GeometryReader{  geometry in
                    Image("Ali")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        .edgesIgnoringSafeArea(.top)
                }
                
                if (speechRecognizer.transcript != ""){
//                    ScrollViewReader{ proxy in
//                        ScrollView {
//                            Text(speechRecognizer.transcript)
//                                .id(speechRecognizer.transcript.count)
//                                .onChange(of: speechRecognizer.transcript) { _, _ in
//                                    if speechRecognizer.transcript.count > 500 { // cambia la lunghezza secondo necessità
//                                        withAnimation {
//                                            proxy.scrollTo(speechRecognizer.transcript.count, anchor: .bottom)
//                                        }
//                                    }
//                                }
//                        }.padding()
//                    }
                    ScrollView{
                        Text(speechRecognizer.transcript)
                    }
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
                    switchRecords(openAI: openAI)
                    isActive.toggle()
                })
                { //LABEL
                    RecordButton()
                }
                .sensoryFeedback(.selection, trigger: isActive)
            }// END VSTACK
            .alert("Do you want to save?", isPresented: $showAlert) {
                Button("Don't Save", role: .cancel) {}
                Button("Save", role: .none) { showSheet = true }
            }
            .sheet(isPresented: $showSheet, content: {
                ModalView(audioTranscript: audioTranscript)
            })
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        showSettings.toggle()
                    }, label: {
                        Image(systemName: "gearshape.circle")
                            .foregroundStyle(.black)
                    })
                }
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
                    .environmentObject(speechRecognizer)
            })
            .animation(.easeInOut, value: speechRecognizer.transcript)
        }
    }
    
    func switchRecords(openAI: Bool){
        ///se openAI attivo fai le opzioni di openAI altrimenti usi Speech
        if !openAI{
            if !isActive{
                speechRecognizer.startTrascribe()
            }
            else {
                audioTranscript = speechRecognizer.transcript
                speechRecognizer.stopTrascribe()
                showAlert = true
            }
        }
        else {
            ///chiamata openAI
            if !isActive{
                audioRecorder.record()
            }
            else {
                audioRecorder.stopRecording { audioData, fileName   in
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
    
    func openAICall(audioTranscript: String, audioData: Data, fileName: String){
        Task{
            do{
                let response = try await OpenAIClassifier.sendPromptToWhisper(audioFile: audioData, fileName: fileName)
                DispatchQueue.main.async{
                    self.audioTranscript = response
                }
            } catch {
                print(error)
            }
        }
    }
}
