//
//  MainUseCase.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/03/15.
//

import Foundation

protocol MainUseCase {

}

final class DefaultMainUseCase {
  
    private let repository: MainRepositoryInterface
  
    init(repository: MainRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchWeatherForecast() {
        self.repository.fetchWeatherForecast()
    }
}

extension DefaultMainUseCase: MainUseCase {
  
}
