//
//  RecordButton.swift
//  Deaf
//
//  Created by Davide Galdiero on 29/05/24.
//

import SwiftUI

struct RecordButton: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.clear)
                .frame(width: 60, height: 60)
                .overlay{
                    Circle()
                        .stroke(Color(red: 1, green: 0.23, blue: 0.19), lineWidth: 2)
                }
            
            Circle()
                .foregroundStyle(Color(red: 1, green: 0.23, blue: 0.19))
                .frame(width: 50, height: 50)
        }
        .frame(alignment: .bottom)
        .padding(.bottom)
    }
}
