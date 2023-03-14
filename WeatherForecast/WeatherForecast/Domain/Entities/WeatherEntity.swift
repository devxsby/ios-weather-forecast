//
//  WeatherEntity.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/03/14.
//

import Foundation

struct WeatherEntity: Decodable {
    let cod: Int
    let name: String
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let rain: Rain
    let clouds: Clouds
    let sys: Sys
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Decodable {
    let speed, gust: Double
    let deg: Int
}

struct Rain: Decodable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Clouds: Decodable {
    let all: Int
}

struct Sys: Decodable {
    let type, id, sunrise, sunset: Int
    let country: String
}
