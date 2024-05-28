//
//  RecordView.swift
//  Deaf
//
//  Created by Davide Galdiero on 28/05/24.
//

import SwiftUI

struct RecordView: View {
    let audioRecord: AudioRecord
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(audioRecord.transcript)
            }
            .navigationTitle(audioRecord.title)
        }
    }
}
