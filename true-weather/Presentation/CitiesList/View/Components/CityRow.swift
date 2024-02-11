//
//  CityRow.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import SwiftUI

struct CityRow: View {
    
    var city: City
    
    var body: some View {
        BlurView(style: .systemUltraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(height: 100)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    Text(city.name).font(.system(size: 26)).fontWeight(.semibold)
                    if !city.country.isEmpty {
                        Text(city.country)
                    }
                    Spacer()
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
            }
    }
}

#Preview {
    CityRow(city: .mock)
}
