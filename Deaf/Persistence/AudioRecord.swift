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
    var title: String = "New transcript"
    var transcript: String = ""
    var date: Date = Date()
    var category: String = "No group"
    
    init(title: String, transcript: String, category: String) {
        self.title = title
        self.transcript = transcript
        self.date = Date()
        self.category = category
    }
}
