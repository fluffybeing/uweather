//
//  WeatherService.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import CoreLocation
import SwiftUI

protocol WeatherServiceProtocol {
  associatedtype T = Decodable

  func currentWeather(location: CLLocationCoordinate2D) async throws -> T
}

struct WeatherURL {
  private let apiKey = "b3216de35750473b30ed9df2e38906c6"
  private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

  func current(for location: CLLocationCoordinate2D) -> URL? {
    // Could have use URL construction using query params and components
    // but it is just one URL so keeping it like this
    return URL(
      string:
        "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric"
    )
  }

}

class WeatherService: WeatherServiceProtocol {
  
  func currentWeather(location: CLLocationCoordinate2D) async throws -> WeatherServiceResponse {
    guard let url = WeatherURL().current(for: location) else {
      // Use logging for it
      fatalError("Invalid URL")
    }

    let (data, response) = try await URLSession.shared.data(
      for: URLRequest(url: url)
    )

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Issue is receiving the data")
    }

    let decodedData = try JSONDecoder().decode(
      WeatherServiceResponse.self,
      from: data
    )

    return decodedData
  }
}

struct WeatherServiceResponse: Decodable {
  var coord: CoordinatesResponse
  var weather: [WeatherResponse]
  var main: MainResponse
  var name: String
  var wind: WindResponse

  struct CoordinatesResponse: Decodable {
    var lon: Double
    var lat: Double
  }

  struct WeatherResponse: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
  }

  struct MainResponse: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
  }

  struct WindResponse: Decodable {
    var speed: Double
    var deg: Double
  }
}

extension WeatherServiceResponse.MainResponse {
  var feelsLike: Double { return feels_like }
  var tempMin: Double { return temp_min }
  var tempMax: Double { return temp_max }
}
