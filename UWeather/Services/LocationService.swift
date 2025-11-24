//
//  LocationService.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import SwiftUI
import CoreLocation
import os

@Observable
final class LocationService : NSObject, CLLocationManagerDelegate {
  private let manager = CLLocationManager()
  private let placeholderLocation = CLLocationCoordinate2D(
    latitude: 59.3327,
    longitude: 18.0656
  )
  
  var location: CLLocationCoordinate2D?
  var isLoading = false
  
  override init() {
    super.init()
    
    manager.delegate = self
  }
  
  func requestLocation() {
    isLoading = true
    manager.requestLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // Putting placeholder
    
    #if targetEnvironment(simulator)
    self.location = placeholderLocation
    LogService.debug.log("Using placeholder location for simulator")
    #else
    self.location = locations.first?.coordinate ?? placeholderLocation
    LogService.debug.log("Using real location in the device")
    #endif
    isLoading = false
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Couldn't get the location", error)
    isLoading = false
  }
}

extension EnvironmentValues {
  @Entry var locationService = LocationService()
}
