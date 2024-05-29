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
            ZStack{
                Image("Ali")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .blur(radius: 15.0)
                    .overlay{
                        Color.white.opacity(0.6)
                    }
                    .edgesIgnoringSafeArea(.top)
                
                VStack(alignment: .leading){
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
                }//END VSTACK
            }//END ZSTACK
            .navigationTitle("Library")
        }
    }
    
    //MARK: Swift Data Function
    func deleteRecord(indexSet: IndexSet){
        for index in indexSet{
            let record = audioRecords[index]
            modelContext.delete(record)
        }
    }
}
