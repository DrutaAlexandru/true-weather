//
//  RootView.swift
//  true-weather
//
//  Created by Alex on 09.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var rootViewModel: RootViewModel = .init()
    
    @StateObject var homeViewModel: HomeViewModel = .init()
    @StateObject var citiesViewModel: CitiesListViewModel = .init()
    @StateObject var weatherViewModel: WeatherViewModel = .init()
    
    @State private var showCitiesList: Bool = false
    @State private var selectedCity: City? = nil
    
    var body: some View {
        ZStack {
            if rootViewModel.checkForCachedDataAvailable() {
                weatherPageView
            } else {
                homeView
            }
        }.onAppear {
            selectedCity = UserDefaultsManager.shared.getSelectedCity()
            if let city = selectedCity {
                weatherViewModel.setCity(city: city)
            }
        }
    }
    
//    private var loadingView: some View {
//        LoadingView()
//    }
    
    private var homeView: some View {
        HomeView(viewModel: homeViewModel)
            .onReceive(homeViewModel.showCitiesListPublisher, perform: { _ in
                showCitiesList.toggle()
            })
            .sheet(isPresented: $showCitiesList, content: {
                citiesListView
            })
    }
    
    private var weatherPageView: some View {
        WeatherView(viewModel: weatherViewModel)
            .onReceive(weatherViewModel.showCitiesListPublisher, perform: { _ in
                showCitiesList.toggle()
            })
            .sheet(isPresented: $showCitiesList, content: {
                citiesListView
            })
    }
    
    private var citiesListView: some View {
        CitiesListView(viewModel: citiesViewModel)
            .onReceive(citiesViewModel.didSelectCityPublisher, perform: { city in
                selectedCity = city
                weatherViewModel.setCity(city: city)
            })
    }
}

#Preview {
    RootView()
}
