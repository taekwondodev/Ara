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
    @State var audioRecord = AudioRecord(title: "", transcript: "")
    
    @State private var isActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    var body: some View {
        VStack{
            Text(speechRecognizer.transcript)
                .padding()
            
            Button(action: {
                if !isActive{
                    speechRecognizer.startTrascribe()
                }
                else {
                    audioRecord.transcript = speechRecognizer.transcript
                    speechRecognizer.stopTrascribe()
                    showAlert = true
                }
                isActive.toggle()
            })
            { //LABEL
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100, alignment: .bottom)
                        .tint(isActive ? .red : .blue)
                    Text(isActive ? "Stop" : "Start")
                        .foregroundStyle(.black)
                        .bold()
                }
            }
            .padding(.top, 40)
        }// END VSTACK
        .alert("Do you want to save?", isPresented: $showAlert) {
            Button("Dont Save", role: .cancel) {}
            Button("Save", role: .none) { showSheet = true }
        }
        .sheet(isPresented: $showSheet, content: {
            VStack {
                Form{
                    TextField("Enter Title", text: $audioRecord.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("Enter Category", text: $audioRecord.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                HStack {
                    Button("OK") {
                        saveTranscript()
                        showSheet = false
                    }
                    .padding()
                    
                    Button("Cancel") { showSheet = false }
                        .padding()
                }
            }
        })
    }
    
    func saveTranscript() {
        let newRecord = AudioRecord(title: audioRecord.title == "" ? "New transcript" : audioRecord.title,
                                    transcript: audioRecord.transcript)
        modelContext.insert(newRecord)
    }
}
