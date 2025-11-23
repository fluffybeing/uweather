//
//  ContentView.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import SwiftUI

struct ContentView: View {
  var weatherService = WeatherService()
  @State var locationService = LocationService()
  @State var weather: WeatherServiceResponse?

  var body: some View {
    VStack {

      if let location = locationService.location {
        if let weather = weather {
          WeatherView(weather: weather)
        } else {
          LoadingView()
            .task {
              do {
                weather = try await weatherService.currentWeather(
                  location: location
                )
              } catch {
                print("Failed to fetch the weather: \(error)")
              }
            }
        }
      } else {
        if locationService.isLoading {
          LoadingView()
        } else {
          WelcomeView()
            .environment(locationService)
        }
      }
    }
    .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    .preferredColorScheme(.dark)
  }
}

#Preview {
  ContentView()
}
