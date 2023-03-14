//
//  MainRepository.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/03/15.
//

import Foundation

final class MainRepository {
    
    private let networkService: APIService
    
    init(service: APIService) {
        self.networkService = service
    }
}

extension MainRepository: MainRepositoryInterface {
    func fetchWeatherForecast() {
    }
}
