//
//  CityModel.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import CoreLocation
import SwiftUI


struct City: Identifiable {
  let id = UUID()
  var name: String
  var longitude: Double
  var latitude: Double

  var imageURL: URL?
  var weather: CurrentWeatherModel?

  var location: CLLocationCoordinate2D {
    .init(latitude: latitude, longitude: longitude)
  }

  init(
    name: String,
    longitude: Double,
    latitude: Double,
    imageURL: URL? = nil,
    weather: CurrentWeatherModel? = nil
  ) {
    self.name = name
    self.longitude = longitude
    self.latitude = latitude
  }
}
