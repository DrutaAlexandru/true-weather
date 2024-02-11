//
//  NoInternetView.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("No Internet Connection")
                    .font(.title)
                    .padding(.bottom, 8)
                
                Text("Check your internet connection and come back to see the latest updates")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 32)
        }
    }
}

#Preview {
    NoInternetView()
}
