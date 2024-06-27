//
//  Ali.swift
//  Deaf
//
//  Created by Davide Galdiero on 04/06/24.
//

import SwiftUI

struct Ali: View {
    var geometry: GeometryProxy
    
    var body: some View {
        Image("Ali")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: geometry.size.height, alignment: .top)
            .opacity(0.6)
            .blur(radius: 15.0)
            .edgesIgnoringSafeArea(.top)
    }
}
