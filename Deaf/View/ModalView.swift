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
    
    @FocusState private var focus: FormFieldFocus?
    var body: some View {
        NavigationStack{
            VStack {
                Form{
                    TextField("Enter Title", text: $audioTitle)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                        .focused($focus, equals: .title)
                        .onSubmit {
                            focus = .category
                        }
                    
                    TextField("Enter Category", text: $audioCategory)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                        .focused($focus, equals: .category)
                        .onAppear(perform: {
                            focus = .title
                        })
                }
            }
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        saveTranscript()
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                }
            }
            .navigationTitle("Title")
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
