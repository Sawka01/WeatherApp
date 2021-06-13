//
//  Weather.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 12.06.2021.
//

import Foundation

struct Weather: Codable {
    let fact: Fact
    let forecasts: [Forecast]
}

struct Fact: Codable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let humidity: Int
    let pressurePA: Double

    private enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case humidity
        case pressurePA = "pressure_pa"
    }
}

struct Forecast: Codable {
    let sunrise: String
    let sunset: String
    let hours: [Hourly]
//    let tempAVG: Int
//    let feelsLike: Int
//    let icon: String

    private enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case hours
//        case tempAVG = "temp_avg"
//        case feelsLike = "feels_like"
//        case icon
    }
}

struct Hourly: Codable {
    let hour: String
    let temp: Int
    let icon: String
    let hourTs: Int

    private enum CodingKeys: String, CodingKey {
        case hour
        case temp
        case icon
        case hourTs = "hour_ts"
    }
}
