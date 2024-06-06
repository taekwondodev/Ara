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
                TextField("Enter Title", text: $audioTitle)
                    .background(RettangoloGrigio(color: Color(red: 0.94, green: 0.94, blue: 0.94)))
                    .padding()
                    .focused($focus, equals: .title)
                    .onAppear(perform: {
                        focus = .title
                    })
                
                NavigationLink {
                    GroupView(newCategory: $audioCategory)
                } label: {
                    ZStack(alignment: .leading){
                        RettangoloGrigio(color: Color(red: 0.94, green: 0.94, blue: 0.94))
                        Text("Group")
                    }
                    .padding()
                }
            }//END VSTACK
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
        }//END NAVIGATION STACK
    }
    
    func saveTranscript() {
        let newRecord = AudioRecord(title: audioTitle == "" ? "New transcript" : audioTitle,
                                    transcript: audioTranscript,
                                    category: audioCategory == "" ? "No group" : audioCategory)
        modelContext.insert(newRecord)
    }
    
    enum FormFieldFocus: Hashable{
        case title
    }
}
