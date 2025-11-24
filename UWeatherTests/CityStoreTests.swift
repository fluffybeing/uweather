//
//  CityStoreTests.swift
//  UWeather
//
//  Created by Ranjan, Rahul on 11/24/25.
//

import Testing
import Foundation
@testable import UWeather

@Suite("CityStore Tests")
struct CityStoreTests {
  @Test("Move cities changes order")
  func testMoveCities() {
    let store = CityStore()
    let initialFirst = store.cities[0].name
    let initialSecond = store.cities[1].name
    
    // Move first city to second position
    store.move(from: IndexSet(integer: 0), to: 2)
    
    #expect(store.cities[0].name == initialSecond)
    #expect(store.cities[1].name == initialFirst)
  }
  
  @Test("Cities have unique IDs")
  func testCitiesHaveUniqueIds() {
    let store = CityStore()
    let ids = store.cities.map { $0.id }
    let uniqueIds = Set(ids)
    
    #expect(ids.count == uniqueIds.count)
  }
}
