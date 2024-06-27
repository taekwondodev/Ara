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
        return Array(Set(audioRecords.map { $0.category }))
    }
    
    @Binding var groupTextField: String
    @Binding var newCategory: String
    var body: some View {
        VStack{
            ForEach(savedGroup, id: \.self){ newGroup in
                let rettangoloColor = newCategory == newGroup ? Color(red: 0.62, green: 0.90, blue: 0.87) : Color(red: 0.94, green: 0.94, blue: 0.94)
                ZStack(alignment: .leading) {
                    RettangoloGrigio(color: rettangoloColor)
                    Text(newGroup)
                        .foregroundStyle(.black)
                        .padding()
                }
                .padding()
                .padding(.trailing, 20)
                .onTapGesture {
                    if newCategory == newGroup{
                        newCategory = ""
                    }
                    else {
                        newCategory = newGroup
                    }
                }
            }
            
            TextField("Insert new category", text: $groupTextField)
                .padding()
                .background(RettangoloGrigio(color: Color(red: 0.94, green: 0.94, blue: 0.94)))
                .padding()
                .padding(.trailing, 20)
        }//END VSTACK
    }
}
