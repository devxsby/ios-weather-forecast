//
//  WeatherRepositoryInterface.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/03/30.
//

import Foundation

protocol WeatherRepositoryInterface {
    func fetchWeather(lat: String, lon: String, completion: @escaping(WeatherEntitiy) -> Void)
}