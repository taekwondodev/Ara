//
//  AraWidgetLiveActivity.swift
//  AraWidget
//
//  Created by Davide Galdiero on 27/06/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct AraWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AraWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(context.attributes.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.leading)
                    .accessibilityHidden(true)
                
                Spacer()
                HStack{
                    Text(context.state.isRecording ? "Ara is recording" : "Ara is not recording")
                        .foregroundStyle(.accent)
                    Image(systemName: context.state.isRecording ? "mic.fill" : "mic.slash.fill")
                        .foregroundStyle(.accent)
                }
                .padding(.trailing, 40)
                Spacer()
            }
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image(context.attributes.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.leading)
                        .accessibilityHidden(true)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.isRecording ? "Ara is recording" : "Ara is not recording")
                }
                //                DynamicIslandExpandedRegion(.bottom) {
                //                    Text("Bottom")
                //                }
            } compactLeading: {
                Image("miniUccello")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .accessibilityLabel("Ara")
                
            } compactTrailing: {
                Image(systemName: context.state.isRecording ? "mic.fill" : "mic.slash.fill")
                    .foregroundStyle(.accent)
            } minimal: {
                Image("miniUccello")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .accessibilityLabel("Ara")
            }
        }
    }
}

extension AraWidgetAttributes {
    fileprivate static var preview: AraWidgetAttributes {
        AraWidgetAttributes(imageName: "uccello")
    }
}

extension AraWidgetAttributes.ContentState {
    fileprivate static var trueRecording: AraWidgetAttributes.ContentState {
        AraWidgetAttributes.ContentState(isRecording: true)
    }
    
    fileprivate static var falseRecording: AraWidgetAttributes.ContentState {
        AraWidgetAttributes.ContentState(isRecording: false)
    }
}

#Preview("Notification", as: .content, using: AraWidgetAttributes.preview) {
    AraWidgetLiveActivity()
} contentStates: {
    AraWidgetAttributes.ContentState.trueRecording
    AraWidgetAttributes.ContentState.falseRecording
}
