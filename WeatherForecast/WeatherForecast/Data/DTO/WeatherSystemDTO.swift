//
//  WeatherSystemDTO.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/04/04.
//

import Foundation

struct WeatherSystemDTO: Decodable {
    let type, id, sunrise, sunset: Int?
    let country: String?
}
