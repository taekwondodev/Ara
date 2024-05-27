//
//  ContentView.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //MARK: SPEECH
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    //MARK: SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query() var audioRecords: [AudioRecord]
    
    //MARK: PiP
    //@StateObject private var viewModel = AVPlayerViewModel()
    
    //MARK: VIEW PROPERTY
    @State private var isActive = false
    
    var body: some View {
        VStack {
            
            //MARK: List of AudioRecordings
            //            if (audioRecords.isEmpty){
            //                Text("No audio stored")
            //            }
            //            else{
            //                List{
            //                    ForEach(audioRecords){ record in
            //                        NavigationLink(destination: TranscriptView()) {
            //                            VStack(alignment: .leading){
            //                                Text(record.title)
            //                                    .font(.headline)
            //                                Text(record.date.formatted(date: .long, time: .shortened))
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            
            
            Picker("Choose lang", selection: $speechRecognizer.language) {
                ForEach(SpeechRecognizer.Language.allCases, id: \.self){ lang in
                    Text(lang.rawValue.capitalized)
                }
            }
            
            Text(speechRecognizer.transcript)
                .padding()
            
            //VideoPlayerView(viewModel: viewModel) MARK: VideoPlayer
            
            //TODO: PASS A URL TO VIEWMODEL OF THE STREAM
            
            Button(action: {
                if !isActive{
                    speechRecognizer.startTrascribe()
                    //viewModel.media = Media(url: <#T##URL#>)
                }
                else {
                    speechRecognizer.stopTrascribe()
                    //viewModel.pause()
                }
                isActive.toggle()
            }) {  //LABEL
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .tint(isActive ? .red : .blue)
                    Text(isActive ? "Stop" : "Start")
                        .foregroundStyle(.black)
                        .bold()
                }
            }
            
        } //END VSTACK
    }
    
    //MARK: Swift Data Function
    func addRecords(audioRecord: AudioRecord){
        modelContext.insert(audioRecord)
    }
}

#Preview {
    ContentView()
}
