//
//  Weather.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

struct CurrentWeatherModel: Decodable {
  let cityName: String
  let weatherType: String
  let temperature: Double
  let feelsLike: Double
  let minTemp: Double
  let maxTemp: Double
  let windSpeed: Double
  let humidity: Double
}

struct WeatherServiceResponseModel: Decodable {
  let name: String
  let weather: [WeatherResponse]
  let main: MainResponse
  let wind: WindResponse
  
  struct WeatherResponse: Decodable {
    let id: Double
    let main: String
    let description: String
    let icon: String
  }
  
  struct MainResponse: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
  }
  
  struct WindResponse: Decodable {
    let speed: Double
    let deg: Double
  }
}

extension WeatherServiceResponseModel.MainResponse {
  var feelsLike: Double { return feels_like }
  var tempMin: Double { return temp_min }
  var tempMax: Double { return temp_max }
}

extension WeatherServiceResponseModel {
  var currentWeather: CurrentWeatherModel {
    .init(
      cityName: name,
      weatherType: weather.first?.main ?? "Sunny",
      temperature: main.temp,
      feelsLike: main.feelsLike,
      minTemp: main.tempMin,
      maxTemp: main.tempMax,
      windSpeed: wind.speed,
      humidity: main.humidity
    )
  }
}
