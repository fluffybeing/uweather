//
//  LoadingView.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/23/25.
//

import SwiftUI

struct LoadingView: View {
  
  var body: some View {
    ProgressView()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .progressViewStyle(CircularProgressViewStyle(tint: .white))
  }
}

#Preview {
  LoadingView()
}
