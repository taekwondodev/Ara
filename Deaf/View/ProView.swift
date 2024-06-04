//
//  ProView.swift
//  Deaf
//
//  Created by Davide Galdiero on 04/06/24.
//

import SwiftUI

struct ProView: View {
    var body: some View {
        VStack {
            Text("Parrot Pro")
                .font(.title)
                .bold()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
                .padding()
            
            HStack{
                Text("Generate")
                    .bold()
                Text("Smart Recap")
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            
            HStack{
                Text("and")
                    .bold()
                Text("Synthesis")
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            
            HStack{
                Text("Billed")
                    .bold()
                Text("Yearly")
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            .padding()
            
            HStack{
                Text("Not Available")
                    .bold()
                Text("Yet")
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            .padding()
            
            Button(action: {}, label: {
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(13)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                    .overlay{
                        Text("UPGRADE YOUR PLAN")
                            .bold()
                            .foregroundStyle(.white)
                    }
            })
            .padding()
            
            Image("Uccello Pro")
                .frame(alignment: .leading)
                .padding(.top)
        }
    }
}

#Preview {
    ProView()
}
