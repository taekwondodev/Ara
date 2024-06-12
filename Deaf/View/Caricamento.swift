//
//  Caricamento.swift
//  Ara
//
//  Created by Davide Galdiero on 12/06/24.
//

import SwiftUI

struct Caricamento: View {
    @State var currentCircle = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let colorCircles: [Color] = [
        Color(red: 0, green: 0.78, blue: 0.75),
        Color(red: 0.97, green: 0.13, blue: 0.13),
        Color(red: 1, green: 0.66, blue: 0)
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: self.currentCircle == index ? 35 : 20,
                           height: self.currentCircle == index ? 35 : 20)
                    .foregroundStyle(colorCircles[index])
                    .animation(.easeInOut(duration: 0.5), value: currentCircle)
                
            }//END ForEach
        }//END HStack
        .onReceive(timer, perform: { _ in
            currentCircle = (currentCircle + 1) % 3
        })
    }
}

#Preview {
    Caricamento()
}
