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
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var recordTitle: String = ""
    var body: some View {
        VStack{
            
            //MARK: Choose the title. Defaults to "new transcript"
            TextField("Insert title of transcript...", text: $recordTitle)
            
            Text(speechRecognizer.transcript)
                .padding()
            
            Button(action: {
                if !isActive{
                    speechRecognizer.startTrascribe()
                }
                else {
                    speechRecognizer.stopTrascribe()
                    //QUI CHIAMA IL SAVE
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
            Button("Save", role: .none) { saveTranscript() }
        }
    }
    
    func saveTranscript() {
        guard !recordTitle.isEmpty else { return }
        let newRecord = AudioRecord (
            title: recordTitle == "" ? "new transcript" : recordTitle,
            transcript: speechRecognizer.transcript
        )
        modelContext.insert(newRecord)
    }
}
