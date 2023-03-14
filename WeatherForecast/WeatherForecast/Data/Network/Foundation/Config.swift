//
//  Config.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/03/15.
//

import Foundation

struct Config {
    enum Network {
        static var baseURL: String {
            return "api.openweathermap.org/data/2.5/"
        }
    }
}
