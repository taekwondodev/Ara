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
            HStack{
                Text("Language:")
                Picker("Choose lang", selection: $speechRecognizer.language) {
                    ForEach(SpeechRecognizer.Language.allCases, id: \.self){ lang in
                        Text(lang.rawValue.capitalized)
                    }
                }
            }
            .padding()
            
            Button(action: {
                //openAI.toggle()  lock at moment
            }, label: {
                HStack{
                    Text("Unlock pro")
                    Image(systemName: "lock")
                }
            })
            .padding()
        }//END VSTACK
    }
}
