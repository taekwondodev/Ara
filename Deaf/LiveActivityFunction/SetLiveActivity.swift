//
//  SetLiveActivity.swift
//  Ara
//
//  Created by Davide Galdiero on 27/06/24.
//

import Foundation
import ActivityKit

class SetLiveActivity: ObservableObject {
    let araWidgetAttributes: AraWidgetAttributes = AraWidgetAttributes(imageName: "uccello")
    @Published var araActivity: Activity<AraWidgetAttributes>? = nil
    
    ///stato iniziale true recording
    func setupActivity(){
        guard araActivity == nil else { return }
        let initialState = AraWidgetAttributes.ContentState(isRecording: true)
        let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 1.0)
        
        do {
            araActivity = try Activity.request(
                attributes: araWidgetAttributes,
                content: content,
                pushType: nil
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///per terminare .end e gli passiamo stato finale
    func endActivity(){
        let finalState = AraWidgetAttributes.ContentState(isRecording: false)
        let content = ActivityContent(state: finalState, staleDate: nil, relevanceScore: 1.0)
        
        Task {
            await araActivity?.end(content, dismissalPolicy: .after(.now.addingTimeInterval(60)))
        }
    }
}
