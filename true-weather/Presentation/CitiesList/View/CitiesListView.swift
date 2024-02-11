//
//  CitiesListView.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import SwiftUI

struct CitiesListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: CitiesListViewModel
    
    var body: some View {
        NavigationView {
            List($viewModel.cities, editActions: viewModel.trimmedSearchText.isEmpty ? [.delete] : []) { city in
                CityRow(city: city.wrappedValue)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        viewModel.selectCity(city.wrappedValue)
                        dismiss()
                    }
                    .disabled(city.wrappedValue == viewModel.selectedCity)
                    .overlay(alignment: .trailing) {
                        if city.wrappedValue == viewModel.selectedCity {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .padding(.trailing)
                        }
                    }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .overlay {
                if !viewModel.trimmedSearchText.isEmpty,
                   viewModel.trimmedSearchText.count < 3 {
                    Text("Continue typing a city\nto start searching")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                if !viewModel.trimmedSearchText.isEmpty,
                    viewModel.trimmedSearchText.count >= 3,
                    !viewModel.isLoading,
                    viewModel.cities.isEmpty  {
                    Text("Search returned no results for \"\(viewModel.trimmedSearchText)\"")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                if viewModel.cities.isEmpty,
                   viewModel.trimmedSearchText.isEmpty,
                   !viewModel.isLoading {
                    Text("No cities to show")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }
            .onChange(of: viewModel.searchText, perform: { value in
                if viewModel.trimmedSearchText.count >= 3 {
                    viewModel.fetchAutocompleteValues()
                }
            })
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .navigationTitle("Cities")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $viewModel.searchText)
        }
    }
}

#Preview {
    CitiesListView(viewModel: .init())
}
