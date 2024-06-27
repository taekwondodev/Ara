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
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .padding(.leading)
                
                Spacer()
                Text(context.state.isRecording ? "Ara is recording" : "Ara is not recording")
                    .padding(.trailing, 40)
                Spacer()
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    Text(context.state.isRecording ? "Ara is recording" : "Ara is not recording")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("emoji")
            }
            .keylineTint(Color.red)
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
