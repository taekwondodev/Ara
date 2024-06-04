//
//  SavedRecords.swift
//  Deaf
//
//  Created by Davide Galdiero on 28/05/24.
//

import SwiftUI
import SwiftData

struct SavedRecords: View {
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    
    //MARK: SWIFT DATA
    @Environment(\.modelContext) var modelContext
    @Query var audioRecords: [AudioRecord]
    
    //MARK: VIEW PROPERTY
//    @State var searchAudio: String = ""
//    var queryAudio: [AudioRecord] {
//        if searchAudio.isEmpty{
//            return audioRecords
//        }
//        
//        let queryAudio = audioRecords.compactMap { record in
//            let titleContainsQuery = record.title.range(of: searchAudio, options: .caseInsensitive) != nil
//            return titleContainsQuery ? record : nil
//        }
//        
//        return queryAudio
//    }
    var groupedAudio: [String: [AudioRecord]] {
        Dictionary(grouping: audioRecords, by: { $0.category })
    }
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                ZStack{
                    Image("Ali")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        .opacity(0.6)
                        .blur(radius: 15.0)
                        .edgesIgnoringSafeArea(.top)
                    
                    //MARK: List of AudioRecordings
                    if (audioRecords.isEmpty){
                        Text("No audio stored")
                    }
                    else{
                        List{
                            ForEach(groupedAudio.keys.sorted(), id: \.self){ category in
                                Section(header: Text(category).font(.title).bold()) {
                                    ForEach(groupedAudio[category] ?? []) { record in
                                        NavigationLink(destination: RecordView(audioRecord: record)) {
                                            VStack(alignment: .leading){
                                                Text(record.title)
                                                    .font(.headline)
                                                Text(record.date.formatted(date: .long, time: .shortened))
                                            }
                                        }
                                    }
                                }
                            }
                            .listRowBackground(Color.clear)
                            .onDelete(perform: deleteRecord)
                        }
                        .frame(height: max(0, geometry.size.height - 220), alignment: .center)
                        .listStyle(.plain)
                    }
                    
                }//END ZSTACK
                .navigationTitle("Library")
//                .searchable(text: $searchAudio)
            }//END GEOMETRY
        }//END NAVIGATIONSTACK
        .animation(.easeInOut, value: audioRecords)
    }
    
    //MARK: Swift Data Function
    func deleteRecord(indexSet: IndexSet){
        for index in indexSet{
            let record = audioRecords[index]
            modelContext.delete(record)
        }
    }
}
