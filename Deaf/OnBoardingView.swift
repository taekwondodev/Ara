//
//  OnBoardingView.swift
//  Deaf
//
//  Created by Davide Galdiero on 29/05/24.
//

import SwiftUI

struct OnBoardingSteps {
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingSteps(image: "parrot1", title: "Transcribe Audio to Text", description: "Easily convert your audio recordings into written text with our powerful transcription tool"),
    OnBoardingSteps(image: "parrot2", title: "Save your Transcripts", description: "Keep your transcriptions organized and accessible by saving them within the app"),
    OnBoardingSteps(image: "parrot3", title: "AI-Powered", description: "Use AI to summarize your transcripts or extract important keywords to quickly find the information you need")
]

struct OnBoardingView: View {
    @State private var currentStep = 0
    @Binding var isOnboarded: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.currentStep = onBoardingSteps.count - 1
                }) {
                    Text("Skip")
                        .padding(16)
                }
            }
            .padding()
            
            TabView(selection: $currentStep){
                ForEach(0..<onBoardingSteps.count, id: \.self) { index in
                    VStack {
                        Image(onBoardingSteps[index].image)  // Correctly use 'index' here
                            .resizable()
                            .frame(width: 200, height: 230)
                        
                        Text(onBoardingSteps[index].title)  // Correctly use 'index' here
                            .font(.title)
                            .bold()
                            .padding(.top, 20)
                        
                        Text(onBoardingSteps[index].description)  // Correctly use 'index' here
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
            
            HStack{
                ForEach(0..<onBoardingSteps.count, id: \.self) { it  in
                    if it == currentStep{
                        
                    Rectangle()
                            .frame(width: 20, height: 10)
                            .cornerRadius(10)
                            .foregroundColor(.cyan)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                }

            }.padding(.bottom,24)
            
            Button(action: {
                if currentStep < onBoardingSteps.count - 1 {
                    currentStep += 1
                } else {
                    // Action for "Get started", e.g., navigate to another view
                    isOnboarded = false
                }
            }) {
                Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get started")
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(currentStep < onBoardingSteps.count - 1 ? Color.cyan : Color.blue)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .bold()
                
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    OnBoardingView(isOnboarded: .constant(true))
}
