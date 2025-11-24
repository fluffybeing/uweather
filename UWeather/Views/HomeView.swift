//
//  CityListView.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import CoreLocationUI
import SwiftUI
import os

struct HomeView: View {
  @State private var cityStore = CityStore()
  @State private var isLoadingWeather = false
  
  @Environment(\.weatherService)
  private var weatherService
  
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("Your Cities")) {
          ForEach(cityStore.cities) { city in
            if let weather = city.weather {
              CityRow(weather: weather)
            } else {
              LoadingView()
            }
          }
          .onMove(perform: cityStore.move)
        }
      }
      .navigationBarItems(leading: EditButton())
      .navigationBarTitle(Text("Home"))
      .task {
        if !isLoadingWeather {
          await loadCitiesWeather()
        }
      }
    }
  }
  
  private func loadCitiesWeather() async {
    isLoadingWeather = true
    
    await withTaskGroup(of: (UUID, CurrentWeatherModel?).self) { group in
      for city in cityStore.cities {
        group.addTask {
          do {
            let weather = try await weatherService.currentWeather(
              location: city.location
            )
            return (city.id, weather)
          } catch {
            await LogService.debug
              .log("Failed to fetch weather for \(city.name): \(error)")
            return (city.id, nil)
          }
        }
      }
      
      for await (cityId, weather) in group {
        if let index = cityStore.cities.firstIndex(where: { $0.id == cityId }),
           let weather = weather {
          cityStore.cities[index].weather = weather
        }
      }
    }
    
    isLoadingWeather = false
  }
}

