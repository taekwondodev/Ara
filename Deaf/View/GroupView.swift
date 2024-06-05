//
//  GroupView.swift
//  Deaf
//
//  Created by Davide Galdiero on 05/06/24.
//

import SwiftUI
import SwiftData

struct GroupView: View {
    @Environment(\.dismiss) private var dismiss
    @Query var audioRecords: [AudioRecord]
    var savedGroup : [String]{
        return audioRecords.map { $0.category }
    }
    
    @State var newCategory: String = ""
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(savedGroup, id: \.self){ newGroup in
                    ZStack(alignment: .leading) {
                        RettangoloGrigio()
                        Text(newGroup)
                    }
                    .padding()
                    .onTapGesture {
                        //seleziono la category e lo rimando indietro
                    }
                }
                
                TextField("Insert new category", text: $newCategory)
                    .background(RettangoloGrigio())
                    .padding()
            }//END VSTACK
            .navigationTitle("Group")
        }// END NAVIGATION STACK
    }
}

#Preview {
    GroupView()
}
