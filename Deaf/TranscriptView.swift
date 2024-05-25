//
//  TranscriptView.swift
//  Deaf
//
//  Created by Davide Galdiero on 25/05/24.
//

import SwiftUI

struct TranscriptView: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    
    var body: some View {
        Text(speechRecognizer.transcript)
            .padding()
    }
}

#Preview {
    TranscriptView()
}
