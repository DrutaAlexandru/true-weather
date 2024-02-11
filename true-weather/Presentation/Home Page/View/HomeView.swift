//
//  HomeView.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showDot = false
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            headingView.padding(.top, 50)
            Spacer()
            searchForCityButton.padding(.bottom, 32)
        }.padding(.horizontal, 20)
    }
    
    private var headingView: some View {
        HStack {
            (Text("Just\nanother\nweather ") +
             Text("app").foregroundColor(Color.red) +
             Text(showDot ? "." : "")).font(.system(size: 50, weight: .semibold))
            Spacer()
        }.onAppear {
            animateDot()
        }
    }
    
    private var searchForCityButton: some View {
        Button {
            viewModel.showCitiesList()
        } label: {
            BlurView(style: .systemThickMaterial)
                .frame(height: 50)
                .clipShape(Capsule())
                .overlay {
                    Text("Search city").fontWeight(.medium).foregroundStyle(Color.primary)
                }
        }
    }
    
    private func animateDot() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 1)) {
                showDot.toggle()
                animateDot()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}
