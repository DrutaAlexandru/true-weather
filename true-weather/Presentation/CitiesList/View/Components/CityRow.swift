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
            .frame(height: 90)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text(city.name).font(.system(size: 26)).fontWeight(.semibold)
                    Text(city.country)
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
            }
    }
}

#Preview {
    CityRow(city: .mock)
}
