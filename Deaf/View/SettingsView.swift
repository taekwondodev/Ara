//
//  SettingsView.swift
//  Deaf
//
//  Created by Davide Galdiero on 28/05/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var speechRecognizer: SpeechRecognizer
    
    var body: some View {
        Picker("Choose lang", selection: $speechRecognizer.language) {
            ForEach(SpeechRecognizer.Language.allCases, id: \.self){ lang in
                Text(lang.rawValue.capitalized)
            }
        }
    }
}
