//
//  RecordView.swift
//  Deaf
//
//  Created by Davide Galdiero on 28/05/24.
//

import SwiftUI

struct RecordView: View {
    @Bindable var audioRecord: AudioRecord
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                Text(audioRecord.date.formatted(date: .long, time: .shortened))
                    .font(.footnote)
                    .frame(alignment: .center)
                
                Spacer()
                
                VStack(alignment: .leading){
                    TextField("Title", text: $audioRecord.title)
                        .font(.title)
                        .bold()
                    TextEditor(text: $audioRecord.transcript)
                        .font(.body)
                }
                .frame(alignment: .leading)
                .padding()
                
                Spacer()
            }//END VStack
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    ShareLink(item: audioRecord.transcript)
                }
            }
        }//END NStack
    }
}
