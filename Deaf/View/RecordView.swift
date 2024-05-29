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
        VStack{
            Text(audioRecord.date.formatted(date: .long, time: .shortened))
                .font(.subheadline)
            
            VStack(alignment: .leading){
                Text(audioRecord.title)
                    .font(.title)
                Text(audioRecord.transcript)
                    .font(.body)
            }
            .padding(.top)
        }
    }
}
