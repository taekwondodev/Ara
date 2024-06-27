//
//  RecordButton.swift
//  Deaf
//
//  Created by Davide Galdiero on 29/05/24.
//

import SwiftUI

struct RecordButton: View {
    var active: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.clear)
                .frame(width: 60, height: 60)
                .overlay{
                    Circle()
                        .stroke(Color(red: 1, green: 0.23, blue: 0.19), lineWidth: 2)
                }
            if !active {
                Circle()
                    .foregroundStyle(Color(red: 1, green: 0.23, blue: 0.19))
                    .frame(width: 50, height: 50)
            }
            else {
                Rectangle()
                    .foregroundStyle(Color(red: 1, green: 0.23, blue: 0.19))
                    .frame(width: 20, height: 20)
            }
        }
        .frame(alignment: .bottom)
        .padding(.bottom)
    }
}

#Preview {
    RecordButton(active: true)
}
