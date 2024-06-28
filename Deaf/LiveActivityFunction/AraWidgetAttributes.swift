//
//  AraWidgetAttributes.swift
//  Ara
//
//  Created by Davide Galdiero on 27/06/24.
//

import Foundation
import ActivityKit

struct AraWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var isRecording: Bool
    }

    // Fixed non-changing properties about your activity go here!
    let imageName: String
}
