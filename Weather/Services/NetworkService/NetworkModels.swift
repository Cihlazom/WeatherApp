//
//  NetworkModels.swift
//  Weather
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation

struct CityWeather: Codable {
    var hourly: [Hourly] = []
    var daily: [Daily] = []
}

struct Hourly: Codable {
    var dt: Int
    var temp: Double
    var weather: [Weather]
}

struct Weather: Codable {
    var icon: String
    var description: String
}

struct Daily: Codable {
    var dt: Int
    var temp: Temp
    var weather: [Weather]
}

struct Temp: Codable {
    var day: Double
    var night: Double
    var min: Double
    var max: Double
}
