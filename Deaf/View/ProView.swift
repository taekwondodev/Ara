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
            Spacer()
            
            Text("Parrot Pro")
                .font(Font.custom("SF Pro", size: 56))
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
                .padding()
            
            HStack{
                Text("Generate")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                Text("Smart Recap")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            
            HStack{
                Text("and")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                Text("Synthesis")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            
            HStack{
                Text("Billed")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                Text("Yearly")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            .padding()
            
            HStack{
                Text("Not Available")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                Text("Yet")
                    .font(Font.custom("SF Pro", size: 28))
                    .bold()
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
            }
            .padding()
            
            Button(action: {}, label: {
                Rectangle()
                    .frame(width: 300, height: 50)
                    .cornerRadius(30)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0, green: 0.78, blue: 0.75), Color(red: 0.98, green: 0.66, blue: 0.02)]), startPoint: .leading, endPoint: .trailing))
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2)
                    .overlay{
                        Text("UPGRADE YOUR PLAN")
                            .bold()
                            .foregroundStyle(.white)
                    }
            })
            .padding()
        }//END VSTACK
        
        VStack{
            Spacer()
            
            HStack{
                Image("Uccello Pro")
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProView()
}
