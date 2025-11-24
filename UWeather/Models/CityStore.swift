//
//  CityStore.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import SwiftUI

@Observable
class CityStore {
  var cities: [City] = [
    City(
      name: "Tokyo",
      longitude: 139.6917,
      latitude: 35.6895,
      imageURL: URL(
        string:
          "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800"
      ),
      weather: nil
    ),

    City(
      name: "New York",
      longitude: -74.0060,
      latitude: 40.7128,
      imageURL: URL(
        string:
          "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800"
      ),
      weather: nil
    ),
    City(
      name: "Paris",
      longitude: 2.3522,
      latitude: 48.8566,
      imageURL: URL(
        string:
          "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800"
      ),
      weather: nil
    ),
    City(
      name: "London",
      longitude: -0.1276,
      latitude: 51.5074,
      imageURL: URL(
        string:
          "https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=800"
      ),
      weather: nil
    )
  ]
}

extension EnvironmentValues {
  @Entry var cityStore: CityStore = CityStore()
}
