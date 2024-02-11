//
//  WeatherDetailsSection.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import SwiftUI

struct WeatherDetailsSection: View {
    
    var weather: Weather
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: 150)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading) {
                            Text("Temperature")
                            Spacer()
                            Text(weather.current.temperature).font(.largeTitle)
                            Spacer()
                            Text("Feels like \(weather.current.apparentTemperature)").font(.subheadline)
                        }.padding()
                    }
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: 150)
                    .overlay {
                        VStack(spacing: 20) {
                            Image(systemName: weather.current.weatherIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text(weather.current.weatherDescription)
                        }
                    }
            }
            HStack(spacing: 20) {
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: 150)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading) {
                            Text("Humidity")
                            Spacer()
                            Text(weather.current.relativeHumidity).font(.largeTitle)
                            Spacer()
                        }.padding()
                    }
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: 150)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading) {
                            Text("Clouds cover")
                            Spacer()
                            Text(weather.current.cloudCover).font(.largeTitle)
                            Spacer()
                        }.padding()

                    }
            }
            HStack(spacing: 20) {
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: 150)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading) {
                            Text("Wind Speed")
                            Spacer()
                            Text(weather.current.windSpeed).font(.largeTitle)
                            Spacer()
                        }.padding()
                    }
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: 150)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading) {
                            Text("Wind Direction")
                            Spacer()
                            Text(weather.current.windDirectionDescription).font(.largeTitle)
                            Spacer()
                        }.padding()

                    }
            }
            VStack(alignment: .leading) {
                Text("7 Day Forecast").font(.title3).fontWeight(.semibold)
                
                ForEach(weather.forecast) { day in
                    HStack {
                        HStack(spacing: 0) {
                            Text(day.dayName)
                            Spacer()
                        }.frame(width: 50)
                        Image(systemName: day.weatherIcon)
                        Spacer()
                        Text(day.minTemperature)
                        Text(" - ")
                        Text(day.maxTemperature)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background {
                BlurView(style: .prominent)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Text("Weather was provided by Open-Meteo platform.").font(.caption2)
            
            Button {
                if let url = URL(string: "https://open-meteo.com/"),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Open-Meteo Website").font(.caption2)
            }.padding(.top, -16)

        }
    }
}

#Preview {
    ScrollView {
        WeatherDetailsSection(weather: .mock).padding(.horizontal, 20)
    }
}
