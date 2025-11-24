//
//  WeatherView.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import SwiftUI
import os

struct WeatherView: View {
  @State var weather: CurrentWeatherModel

  var body: some View {
    ZStack(alignment: .leading) {
      VStack {
        WeatherHeaderView(
          cityName: weather.cityName,
          currentDate: Date()
        )

        Spacer()

        WeatherMainContentView(
          weatherType: weather.weatherType,
          feelsLike: weather.feelsLike
        )

      }.padding()
        .frame(maxWidth: .infinity, alignment: .leading)

      WeatherBottomSheetView(weather: weather)
    }
    .edgesIgnoringSafeArea(.bottom)
  }
}

// MARK: - Header Component
struct WeatherHeaderView: View {
  let cityName: String
  let currentDate: Date

  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(cityName)
        .bold()
        .font(.title)

      Text(
        "Today \(currentDate.formatted(date: .abbreviated, time: .shortened))"
      )
      .fontWeight(.light)

    }.frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - Main Content Component
struct WeatherMainContentView: View {
  let weatherType: String
  let feelsLike: Double

  var body: some View {
    VStack {
      WeatherTemperatureDisplay(
        weatherType: weatherType,
        feelsLike: feelsLike
      )

      Spacer()
        .frame(height: 80)

      WeatherCityImageView()

      Spacer()

    }.frame(maxWidth: .infinity)
  }
}

// MARK: - Temperature Display Component
struct WeatherTemperatureDisplay: View {
  let weatherType: String
  let feelsLike: Double

  var body: some View {
    HStack {
      VStack(spacing: 20) {
        Image(systemName: "sun.max")
          .font(.system(size: 40))

        Text(weatherType)

      }.frame(width: 150, alignment: .leading)

      Spacer()

      Text(feelsLike.roundDouble() + "°")
        .font(.system(size: 100))
        .fontWeight(.bold)
        .padding()
    }
  }
}

// MARK: - City Image
struct WeatherCityImageView: View {
  var body: some View {
    AsyncImage(
      url: URL(
        string:
          "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png"
      )
    ) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 350)
    } placeholder: {
      ProgressView()
    }
  }
}

// MARK: - Bottom Sheet Component
struct WeatherBottomSheetView: View {
  let weather: CurrentWeatherModel

  var body: some View {
    VStack {
      Spacer()

      VStack(alignment: .leading, spacing: 20) {
        Text("Current weather")
          .bold()
          .padding(.bottom)

        WeatherStatsGrid(weather: weather)

      }.frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.bottom, 20)
        .foregroundColor(
          Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
        )
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
  }
}

// MARK: - Data Grid
struct WeatherStatsGrid: View {
  let weather: CurrentWeatherModel

  var body: some View {
    VStack(spacing: 20) {
      HStack {
        WeatherRow(
          logo: "thermometer",
          name: "Min temp",
          value: weather.minTemp.roundDouble() + "°"
        )

        Spacer()

        WeatherRow(
          logo: "thermometer",
          name: "Max temp",
          value: weather.maxTemp.roundDouble() + "°"
        )
      }

      HStack {
        WeatherRow(
          logo: "wind",
          name: "Wind speed",
          value: weather.windSpeed.roundDouble() + "m/s"
        )

        Spacer()

        WeatherRow(
          logo: "humidity",
          name: "Humidity",
          value: weather.humidity.roundDouble() + "%"
        )
      }
    }
  }
}

#Preview {
  //  WeatherView(weather: )
}
