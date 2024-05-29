//
//  TranscriptView.swift
//  Deaf
//
//  Created by Davide Galdiero on 25/05/24.
//

import SwiftUI
import SwiftData

struct TranscriptView: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    
    @Environment(\.modelContext) var modelContext
    @State var audioTranscript: String = ""
    @State var audioTitle: String = ""
    
    @State private var isActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    var body: some View {
        ZStack{
            Image("Ali")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .edgesIgnoringSafeArea(.top)
            
            VStack{
                Image("Uccello")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .offset(x: isActive ? -UIScreen.main.bounds.width : 0, y: 0)
                    .animation(.easeInOut(duration: 1), value: isActive)
                
                Text(speechRecognizer.transcript)
                    .frame(maxHeight: 200, alignment: .center)
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
                    ZStack {
                        Circle()
                            .foregroundStyle(.clear)
                            .frame(width: 60, height: 60)
                            .overlay{
                                Circle()
                                    .stroke(Color(red: 1, green: 0.23, blue: 0.19), lineWidth: 2)
                            }
                        
                        Circle()
                            .foregroundStyle(Color(red: 1, green: 0.23, blue: 0.19))
                            .frame(width: 50, height: 50)
                    }
                    .frame(alignment: .bottom)
                    .padding(.bottom)
                }
            }//END VSTACK
        }// END ZSTACK
        .alert("Do you want to save?", isPresented: $showAlert) {
            Button("Dont Save", role: .cancel) {}
            Button("Save", role: .none) { showSheet = true }
        }
        .sheet(isPresented: $showSheet, content: {
            LazyVStack {
                TitleView(audioTitle: $audioTitle)
                
                HStack {
                    Button("OK") {
                        saveTranscript()
                        showSheet = false
                    }
                    .padding(.horizontal)
                    
                    Button("Cancel") { showSheet = false }
                        .padding(.horizontal)
                }
                .padding()
            }
        })
    }
    
    func saveTranscript() {
        let newRecord = AudioRecord(title: audioTitle == "" ? "New transcript" : audioTitle,
                                    transcript: audioTranscript)
        modelContext.insert(newRecord)
    }
}
