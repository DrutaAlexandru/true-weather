//
//  WeatherHeadingSection.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import SwiftUI

struct WeatherHeadingSection: View {
    
    var city: City
    var weather: Weather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            topSection
            Spacer()
            bottomSection
        }.background(alignment: .topTrailing) {
            backgroundImage
        }
    }
    
    private var backgroundImage: some View {
        Image(systemName: weather.current.weatherIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 500, height: 500)
            .padding(.trailing, -250)
            .padding(.top, -150)
            .blur(radius: 40)
    }
    
    private var topSection: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(city.name)
                    .font(.title3)
                
                Text(weather.current.temperature)
                    .font(.system(size: 80, weight: .medium))
            }
            Spacer()
        }.padding(.top, 30)
    }
    
    private var bottomSection: some View {
        VStack(spacing: 60) {
            HStack(spacing: 0) {
                Spacer()
                titleText(from: TextDivision(text: weather.current.weatherTrueTitle),
                          with: weather.current.weatherTrueAccentColor)
            }
            
            HStack(spacing: 0) {
                Spacer()
                Text(weather.current.weatherTrueSubtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
        }
    }
    
    private func titleText(from text: TextDivision, with color: String) -> some View {
        return (
            Text(text.prefix) +
            Text(text.root).foregroundColor(Color(hex: color)) +
            Text(text.suffix)
        )
        .font(.system(size: 50, weight: .semibold))
        .multilineTextAlignment(.trailing)
    }
}

private struct TextDivision {
    let prefix: String
    let root: String
    let suffix: String
    
    init(text: String) {
        let firstSeparationParts = text.components(separatedBy: "<<")
        
        let secondPartToSeparate: String
        
        if firstSeparationParts.count == 1 {
            prefix = ""
            secondPartToSeparate = firstSeparationParts[0]
        } else {
            prefix = firstSeparationParts[0]
            secondPartToSeparate = firstSeparationParts[1]
        }
        
        let secondSeparationParts = secondPartToSeparate.components(separatedBy: ">>")
        
        root = secondSeparationParts[0]
        
        if secondSeparationParts.count == 1 {
            suffix = ""
        } else {
            suffix = secondSeparationParts[1]
        }
    }
}

#Preview {
    WeatherHeadingSection(city: .mock, weather: .mock).padding(.horizontal, 20)
}
