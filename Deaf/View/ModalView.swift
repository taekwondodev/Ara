//
//  ModalView.swift
//  Deaf
//
//  Created by Davide Galdiero on 29/05/24.
//

import SwiftUI
import SwiftData

struct ModalView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    let audioTranscript: String
    @Binding var audioTitle: String
    @FocusState private var focus: FormFieldFocus?
    var body: some View {
        NavigationStack{
            VStack {
                Form{
                    TextField("Enter Title", text: $audioTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($focus, equals: .title)
                        .onSubmit {
                            focus = .category
                        }
                    
                    TextField("Enter Category", text: $audioTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($focus, equals: .category)
                        .onAppear(perform: {
                            focus = .title
                        })
                    
                    HStack {
                        Button("OK") {
                            saveTranscript()
                            dismiss()
                        }
                        .padding(.horizontal)
                        
                        Button("Cancel") { dismiss() }
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
            .navigationTitle("Title")
        }
    }
    
    func saveTranscript() {
        let newRecord = AudioRecord(title: audioTitle == "" ? "New transcript" : audioTitle,
                                    transcript: audioTranscript)
        modelContext.insert(newRecord)
    }
    
    enum FormFieldFocus: Hashable{
        case title, category
    }
}
