//
//  RootView.swift
//  true-weather
//
//  Created by Alex on 09.02.2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let vm = WeatherViewModel(coordinates: .init(latitude: 47, longitude: 28))
            vm.loadData()
        }
    }
}

#Preview {
    RootView()
}
