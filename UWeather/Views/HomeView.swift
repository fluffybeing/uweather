//
//  CityListView.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import SwiftUI
import os

struct CityListView: View {
  @State private var cityStore = CityStore()

  @Environment(\.weatherService)
  private var weatherService

  var body: some View {
    VStack {
      NavigationView {
        List {
          Section(header: Text("Your Cities")) {
            ForEach(cityStore.cities.indices, id: \.self) { index in
              if let weather = cityStore.cities[index].weather {
                CityRow(weather: weather)
              } else {
                LoadingView()
                  .task {
                    do {
                      cityStore.cities[index].weather =
                        try await weatherService.currentWeather(
                          location: cityStore.cities[index].location
                        )
                    } catch {
                      LogService.debug.log(
                        "Failed to fetch the weather: \(error)"
                      )
                    }
                  }
              }
            }
            .onMove(perform: move)
          }
        }
        .navigationBarItems(leading: EditButton())
        .navigationBarTitle(Text("Weather"))
      }
    }
    .background(.green)
  }

  private func move(from source: IndexSet, to destination: Int) {
    var removeCities: [City] = []

    for index in source {
      removeCities.append(cityStore.cities[index])
      cityStore.cities.remove(at: index)
    }

    cityStore.cities.insert(contentsOf: removeCities, at: destination)
  }
}
