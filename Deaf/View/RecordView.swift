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
        VStack(alignment: .leading){
            Text(audioRecord.date.formatted(date: .long, time: .shortened))
            Text(audioRecord.transcript)
        }
    }
}
