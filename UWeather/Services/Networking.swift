//
//  Networking.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import SwiftUI

enum NetworkingError: Error {
  case invalidURL
  case encodingFailed(innerError: EncodingError)
  case decodingFailed(innerError: DecodingError)
  case invalidStatusCode(statusCode: Int)
  case requestFailed(innerError: URLError)
  case otherError(innerError: Error)
}
