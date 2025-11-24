//
//  UWeatherApp.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import SwiftUI

@main
struct UWeatherApp: App {
  
  init() {
    // Caching for the App
    URLCache.shared.memoryCapacity = 50_000_000 // 50 MB
    URLCache.shared.diskCapacity = 1_000_000_000 // 1 GB
  }
  
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environment(CityStore())
    }
  }
}
