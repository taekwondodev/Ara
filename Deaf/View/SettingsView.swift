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
    
    @State var showLanguage: Bool = false
    @State var showPro: Bool = false
    var body: some View {
        VStack{
            Text("Pro Plan")
                .font(.title)
                .bold()
            Button(action: {
                showPro.toggle()
            }, label: {
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(13)
                    .foregroundStyle(openAI ? LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                    .overlay{
                        HStack{
                            Text("Parrot Pro")
                                .foregroundStyle(openAI ? .white: .black)
                                .padding(.horizontal)
                            Text("One Year Subscription")
                                .padding(.horizontal)
                        }
                    }
            })
            .sheet(isPresented: $showPro, content: {
                ProView()
            })
            
            Text("Language")
                .font(.title)
                .bold()
            Button(action: {
                showLanguage.toggle()
            }, label: {
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(13)
                    .foregroundStyle(.white)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                    .overlay{
                        HStack{
                            Image(assignFlag(lang: speechRecognizer.language))
                                .padding(.horizontal)
                            
                            Text(speechRecognizer.language.rawValue.capitalized)
                                .padding(.horizontal)
                        }
                    }
            })
            .sheet(isPresented: $showLanguage, content: {
                VStack(alignment: .leading){
                    Text("Language")
                        .font(.title)
                        .bold()
                    
                    ForEach(SpeechRecognizer.Language.allCases, id: \.self){ lang in
                        Rectangle()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(13)
                            .foregroundStyle(speechRecognizer.language == lang ? Color(red: 0.62, green: 0.90, blue: 0.87) : Color.white)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                            .padding()
                            .overlay{
                                //MARK: bandiera e language
                                HStack{
                                    Image(assignFlag(lang: lang))
                                        .padding(.horizontal)
                                    
                                    Text(lang.rawValue.capitalized)
                                        .padding(.horizontal)
                                }
                            }
                            .onTapGesture {
                                speechRecognizer.language = lang
                            }
                    }
                }
            })
        }//END VSTACK
    }
    
    func assignFlag(lang: SpeechRecognizer.Language) -> String {
        if (lang == .italian){
            return "🇮🇹"
        }
        else if (lang == .english){
            return "🇬🇧"
        }
        else {
            return "🇪🇸"
        }
    }
}


//                Picker("Choose lang", selection: $speechRecognizer.language) {
//                    ForEach(SpeechRecognizer.Language.allCases, id: \.self){ lang in
//                        Text(lang.rawValue.capitalized)
//                    }
//                }
