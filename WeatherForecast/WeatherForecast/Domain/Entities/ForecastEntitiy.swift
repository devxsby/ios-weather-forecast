//
//  ForecastEntitiy.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/03/14.
//

import Foundation

struct ForecastEntitiy: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

struct List: Decodable {
    let dtTxt: String
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let rain: ForecastRain?
    let sys: ForecastSys
    
    enum CodingKeys: String, CodingKey {
        case main, weather, clouds, wind, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct City: Decodable {
    let name, country: String
    let id, population, timezone, sunrise, sunset: Int
    let coord: Coord
}

struct ForecastRain: Decodable {
    let the3H: Double
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct ForecastSys: Decodable {
    let pod: String
}
