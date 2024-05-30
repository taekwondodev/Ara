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
    @Query(sort: [SortDescriptor(\AudioRecord.date, order: .reverse)]) var audioRecords: [AudioRecord]
    
    var body: some View {
        NavigationStack{
            VStack{
                Ali()
                
                //MARK: List of AudioRecordings
                if (audioRecords.isEmpty){
                    Text("No audio stored")
                }
                else{
                    List{
                        ForEach(audioRecords){ record in
                            NavigationLink(destination: RecordView(audioRecord: record)) {
                                VStack(alignment: .leading){
                                    Text(record.title)
                                        .font(.headline)
                                    Text(record.date.formatted(date: .long, time: .shortened))
                                }
                            }
                        }
                        .onDelete(perform: deleteRecord)
                    }
                }
            }//END ZSTACK
            .navigationTitle("Library")
        }//END NAVIGATIONSTACK
    }
    
    //MARK: Swift Data Function
    func deleteRecord(indexSet: IndexSet){
        for index in indexSet{
            let record = audioRecords[index]
            modelContext.delete(record)
        }
    }
}
