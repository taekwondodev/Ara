//
//  ModalView.swift
//  Deaf
//
//  Created by Davide Galdiero on 29/05/24.
//

import SwiftUI
import SwiftData

struct ModalView: View {
    @Environment(\.modelContext) var modelContext
    
    let audioTranscript: String
    @State var audioTitle: String = ""
    @State var audioCategory: String = ""
    
    @Binding var showSheet: Bool
    @FocusState private var focus: FormFieldFocus?
    
    //MARK: GROUP VIEW PROPERTY
    @Query var audioRecords: [AudioRecord]
    var savedGroup : [String]{
        return Array(Set(audioRecords.map { $0.category }))
    }
    @State var groupTextField: String = ""
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    TextField("Enter Title", text: $audioTitle)
                        .foregroundStyle(.black)
                        .padding()
                        .background(RettangoloGrigio(color: Color(red: 0.94, green: 0.94, blue: 0.94)))
                        .padding()
                        .focused($focus, equals: .title)
                        .onAppear(perform: {
                            focus = .title
                        })
                    
                    //GROUP
                    DisclosureGroup(
                        content: {
                            GroupView(groupTextField: $groupTextField, newCategory: $audioCategory)
                        },
                        label: {
                            ZStack(alignment: .leading){
                                RettangoloGrigio(color: Color(red: 0.94, green: 0.94, blue: 0.94))
                                Text("Group")
                                    .padding()
                            }
//                            .padding()
                        }
                    )
                    .padding()
                }//END VSTACK
                .navigationTitle("Title")
                .toolbar{
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            saveTranscript()
                            showSheet = false
                        }, label: {
                            Text("Done")
                        })
                    }
                }
            }//END SCROLL VIEW
        }//END NAVIGATION STACK
    }
    
    func saveTranscript() {
        var category: String = ""
        if savedGroup.contains(audioCategory){
            category = audioCategory
        }
        else{
            category = groupTextField == "" ? "No group" : groupTextField
        }
        
        let newRecord = AudioRecord(title: audioTitle == "" ? "New transcript" : audioTitle,
                                    transcript: audioTranscript,
                                    category: category)
        modelContext.insert(newRecord)
    }
    
    enum FormFieldFocus: Hashable{
        case title
    }
}
