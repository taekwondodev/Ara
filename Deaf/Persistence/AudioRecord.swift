//
//  AudioRecord.swift
//  Deaf
//
//  Created by Davide Galdiero on 27/05/24.
//

import Foundation
import SwiftData

@Model
class AudioRecord{
    var title: String
    let transcript: String
    var date: Date
    
    init(title: String, transcript: String) {
        self.title = title
        self.transcript = transcript
        self.date = Date()
    }
}
