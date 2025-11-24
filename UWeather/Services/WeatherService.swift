//
//  WeatherService.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import CoreLocation
import SwiftUI
import os

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
  func currentWeather(location: CLLocationCoordinate2D) async throws -> CurrentWeatherModel {
    do {
      guard let url = WeatherURL().current(for: location) else {
        LogService.debug.log("Invalid URL")
        throw NetworkingError.invalidURL
      }
      
      let (data, response) = try await URLSession.shared.data(
        for: URLRequest(url: url)
      )
      
      LogService.debug.log("URL is \(url) and response is \(response)")

      guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
        throw NetworkingError.invalidStatusCode(statusCode: -1)
      }
      
      guard (200...299).contains(statusCode) else {
        throw NetworkingError.invalidStatusCode(statusCode: statusCode)
      }
      
      let jsonResponse = try JSONDecoder().decode(
        WeatherServiceResponseModel.self,
        from: data
      )
      
      return jsonResponse.currentWeather
    } catch let error as DecodingError {
      throw NetworkingError.decodingFailed(innerError: error)
    } catch let error as EncodingError {
      throw NetworkingError.encodingFailed(innerError: error)
    } catch let error as URLError {
      throw NetworkingError.requestFailed(innerError: error)
    } catch let error as NetworkingError {
      throw error
    } catch {
      throw NetworkingError.otherError(innerError: error)
    }
  }
}
