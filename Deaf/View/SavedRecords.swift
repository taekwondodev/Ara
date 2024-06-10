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
    @State var searchAudio: String = ""
    var filteredAudioRecords: [AudioRecord] {
        if searchAudio.isEmpty {
            return audioRecords
        } else {
            return audioRecords.filter { $0.title.contains(searchAudio) || $0.category.contains(searchAudio) }
        }
    }
    var groupedAudio: [String: [AudioRecord]] {
        Dictionary(grouping: filteredAudioRecords, by: { $0.category })
    }
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                ZStack{
                    Ali(geometry: geometry)
                    
                    //MARK: List of AudioRecordings
                    if (audioRecords.isEmpty){
                        Text("No audio stored")
                    }
                    else{
                        audioListView(geometry: geometry)
                            .padding(.bottom, 50)
                    }
                    
                }//END ZSTACK
                .navigationTitle("Library")
                .searchable(text: $searchAudio)
            }//END GEOMETRY
        }//END NAVIGATIONSTACK
    }
    
    func audioListView(geometry: GeometryProxy) -> some View {
        List{
            ForEach(groupedAudio.keys.sorted(), id: \.self){ category in
                Section(header: Text(category).font(.title).bold().foregroundStyle(.black)) {
                    ForEach(groupedAudio[category] ?? []) { record in
                        NavigationLink(destination: RecordView(audioRecord: record)) {
                            VStack(alignment: .leading){
                                Text(record.title)
                                    .font(.headline)
                                Text(record.date.formatted(date: .long, time: .shortened))
                            }
                        }
                    }
                    .onDelete { indexSet in
                        deleteRecord(category: category, indexSet: indexSet)
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .background(Color.clear)
        .listStyle(.plain)
    }
    //MARK: Swift Data Function
    func deleteRecord(category: String, indexSet: IndexSet){
        for index in indexSet{
            if let record = groupedAudio[category]?[index] {
                modelContext.delete(record)
            }
        }
    }
}
