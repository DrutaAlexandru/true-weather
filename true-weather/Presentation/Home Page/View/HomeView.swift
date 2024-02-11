//
//  HomeView.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @State private var showDot = false
    @State private var showLocationErrorAlert = false
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            headingView.padding(.top, 50)
            Spacer()
            searchForCityButton
            currentLocationButton.padding(.bottom, 32)
        }
        .padding(.horizontal, 20)
        .onReceive(viewModel.showLocationErrorPublisher, perform: { _ in
            showLocationErrorAlert.toggle()
        })
        .alert("Location Denied", isPresented: $showLocationErrorAlert) {
            Button("Go to Settings", action: {
                UIApplication.shared.openAppSettings()
            })
            Button("Cancel", role: .cancel, action: { })
        } message: {
            Text("You have denied you location permissions in settings, please go to settings and allow location permissions to continue.")
        }
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
    
    private var currentLocationButton: some View {
        Button {
            viewModel.requestLocationPermission()
        } label: {
            BlurView(style: .systemThickMaterial)
                .frame(height: 50)
                .clipShape(Capsule())
                .overlay {
                    HStack {
                        Text("Current Location").fontWeight(.medium).foregroundStyle(Color.primary)
                        Image(systemName: "location.fill").foregroundStyle(Color.primary)
                    }
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
