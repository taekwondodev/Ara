//
//  RettangoloGrigio.swift
//  Deaf
//
//  Created by Davide Galdiero on 05/06/24.
//

import SwiftUI

struct RettangoloGrigio: View {
    var body: some View {
        Rectangle()
            .cornerRadius(13)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color(red: 0.94, green: 0.94, blue: 0.94))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
    }
}
