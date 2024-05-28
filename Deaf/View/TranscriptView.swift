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
    var body: some View {
        VStack{
            Text(speechRecognizer.transcript)
                .padding()
            
            Button(action: {
                if !isActive{
                    speechRecognizer.startTrascribe()
                }
                else {
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
            Button("Save", role: .none) { saveRecords() }
        }
    }
    
    func saveRecords(){
        let record = AudioRecord(title: "new", transcript: speechRecognizer.transcript)
        modelContext.insert(record)
    }
}
