//
//  GroupView.swift
//  Deaf
//
//  Created by Davide Galdiero on 05/06/24.
//

import SwiftUI
import SwiftData

struct GroupView: View {
    @Query var audioRecords: [AudioRecord]
    var savedGroup : [String]{
        return audioRecords.map { $0.category }
    }
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    GroupView()
}
