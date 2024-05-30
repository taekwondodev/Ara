//
//  Ali.swift
//  Deaf
//
//  Created by Davide Galdiero on 30/05/24.
//

import SwiftUI

struct Ali: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Image("Ali")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                    .blur(radius: 15.0)
            }
            
            Color.white.opacity(0.6)
                .frame(maxWidth: .infinity)
                .frame(height: 315, alignment: .top)
        }
    }
}
