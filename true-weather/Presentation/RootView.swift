//
//  RootView.swift
//  true-weather
//
//  Created by Alex on 09.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var weatherViewModel: HomeViewModel = .init()
    @State var showCitiesList: Bool = false
    
    var body: some View {
        HomeView(viewModel: weatherViewModel)
            .onReceive(weatherViewModel.showCitiesListPublisher, perform: { _ in
                showCitiesList.toggle()
            })
            .sheet(isPresented: $showCitiesList, content: {
                CitiesListView(viewModel: .init())
            })
    }
}

#Preview {
    RootView()
}
