//
//  WeatherView.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var errorValue: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                if viewModel.isLoading {
                    loadingView(proxy: proxy)
                } else if let weather = viewModel.weatherData {
                    contentView(proxy: proxy, weather: weather)
                } else {
                    brokenPage(proxy: proxy)
                }
            }
            .refreshable {
                viewModel.loadData(force: true)
            }
            .scrollIndicators(.never, axes: .vertical)
        }
        .overlay(alignment: .topTrailing) {
            menuButtons
        }
        .onAppear {
            viewModel.loadData()
        }
        .onReceive(viewModel.showErrorPublisher, perform: { value in
            errorValue = value
            showError.toggle()
        })
        .alert(errorValue, isPresented: $showError) {
            Button(action: { }, label: { Text("Ok") })
        }
    }
    
    private var menuButtons: some View {
        HStack(spacing: 20) {
            Button(action: {
                
            }, label: {
                Image(systemName: "square.and.arrow.up")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.secondary)
            })
            
            Button(action: {
                
            }, label: {
                Image(systemName: "list.bullet")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.secondary)
            })
        }.padding(.horizontal, 24)
    }
    
    private func loadingView(proxy: GeometryProxy) -> some View {
        LoadingView().frame(height: proxy.size.height)
    }
    
    private func contentView(proxy: GeometryProxy, weather: Weather) -> some View {
        VStack(spacing: 40) {
            
            WeatherHeadingSection(
                city: viewModel.city,
                weather: weather
            ).frame(height: proxy.size.height)
            
            WeatherDetailsSection(weather: weather)
            
        }.padding(.horizontal, 20)
    }
    
    private func brokenPage(proxy: GeometryProxy) -> some View {
        ZStack {
            Color.clear
            VStack {
                Spacer()
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("Whoops...")
                    .font(.title)
                Text("Something went wrong when downloading the weather data. Please try again.")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                Spacer()
            }.padding(.horizontal, 20)
        }.frame(height: proxy.size.height)
    }
}

#Preview {
    WeatherView(viewModel: .init(city: .mock))
}
