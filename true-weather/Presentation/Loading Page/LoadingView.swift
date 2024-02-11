//
//  LoadingView.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var dotsCount = 0
    
    var body: some View {
        ZStack {
            Color.clear
            Text("Loading\n" + String(repeating: ".", count: dotsCount % 4))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .onAppear {
                    animateDots()
                }
                .frame(width: 130)
        }
    }
    
    private func animateDots() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                dotsCount += 1
                animateDots()
            }
        }
    }
}

#Preview {
    LoadingView()
}
