//
//  SettingsView.swift
//  Deaf
//
//  Created by Davide Galdiero on 28/05/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    @AppStorage("OpenAi") var openAI: Bool = false
    
    var body: some View {
        VStack{
            Picker("Choose lang", selection: $speechRecognizer.language) {
                ForEach(SpeechRecognizer.Language.allCases, id: \.self){ lang in
                    Text(lang.rawValue.capitalized)
                }
            }
            
            Button(action: {
                openAI.toggle()
            }, label: {
                Text("OpenAI")
                    .foregroundStyle(openAI ? .red : .blue)
            })
        }//END VSTACK
    }
}
