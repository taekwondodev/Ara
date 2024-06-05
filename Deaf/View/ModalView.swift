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
    @State var audioTitle: String = ""
    @State var audioCategory: String = ""
    
    @State var showGroup: Bool = false
    @FocusState private var focus: FormFieldFocus?
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter Title", text: $audioTitle)
                    .background(RettangoloGrigio())
                    .padding()
                    .focused($focus, equals: .title)
                    .onSubmit {
                        focus = .category
                    }
                
                TextField("Enter Category", text: $audioCategory)
                    .background(RettangoloGrigio())
                    .padding()
                    .focused($focus, equals: .category)
                    .onAppear(perform: {
                        focus = .title
                    })
            }
            .navigationTitle("Title")
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        saveTranscript()
                        dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
            }
        }
    }
    
    func saveTranscript() {
        let newRecord = AudioRecord(title: audioTitle == "" ? "New transcript" : audioTitle,
                                    transcript: audioTranscript,
                                    category: audioCategory == "" ? "No group" : audioCategory)
        modelContext.insert(newRecord)
    }
    
    enum FormFieldFocus: Hashable{
        case title
        case category
    }
}
