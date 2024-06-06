//
//  GroupView.swift
//  Deaf
//
//  Created by Davide Galdiero on 05/06/24.
//

import SwiftUI
import SwiftData

struct GroupView: View {
    @Environment(\.modelContext) var modelContext
    @Query var audioRecords: [AudioRecord]
    var savedGroup : [String]{
        return audioRecords.map { $0.category }
    }
    
    let audioTranscript: String
    let audioTitle: String
    
    @Binding var newCategory: String
    @Binding var showSheet: Bool
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(savedGroup, id: \.self){ newGroup in
                    let rettangoloColor = newCategory == newGroup ? Color(red: 0.62, green: 0.90, blue: 0.87) : Color(red: 0.94, green: 0.94, blue: 0.94)
                    ZStack(alignment: .leading) {
                        RettangoloGrigio(color: rettangoloColor)
                        Text(newGroup)
                            .padding()
                    }
                    .padding()
                    .onTapGesture {
                        newCategory = newGroup
                    }
                }
                
                TextField("Insert new category", text: $newCategory)
                    .padding()
                    .background(RettangoloGrigio(color: Color(red: 0.94, green: 0.94, blue: 0.94)))
                    .padding()
            }//END VSTACK
            .navigationTitle("Group")
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
        }// END NAVIGATION STACK
    }
    
    func saveTranscript() {
        let newRecord = AudioRecord(title: audioTitle == "" ? "New transcript" : audioTitle,
                                    transcript: audioTranscript,
                                    category: newCategory == "" ? "No group" : newCategory)
        modelContext.insert(newRecord)
    }
}
