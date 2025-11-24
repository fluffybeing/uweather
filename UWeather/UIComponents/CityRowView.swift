//
//  CityRow.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import SwiftUI

struct CityRow: View {
  @State var weather: CurrentWeatherModel

  var body: some View {
    NavigationLink(
      destination: WeatherView(weather: weather)
    ) {
      HStack(alignment: .firstTextBaseline) {
        Text(weather.cityName)
          .lineLimit(nil)
          .font(.title)
        Spacer()
        HStack {
          Text(weather.feelsLike.roundDouble() + "-ºC")
            .foregroundColor(.gray)
            .font(.title)
          Image(systemName: "cloud.fill")
            .foregroundColor(Color.gray)
            .font(.title)
        }
      }
      .padding([.trailing, .top, .bottom])
    }
  }
}

#Preview {

}
