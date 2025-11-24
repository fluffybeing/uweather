//
//  LoggingService.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import os
import Foundation

enum LogService {
  static let debug = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? "com.ouira.uweather",
    category: "Debug"
  )
}
