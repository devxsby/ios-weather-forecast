//
//  WeatherTransform.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/03/30.
//

import Foundation

extension WeatherResponseDTO {
    func toDomain() -> WeatherEntity {
        let tempMin = main?.tempMin
        let tempMax = main?.tempMax
        let lat = coord?.lat
        let lon = coord?.lon

        return .init(weather: weather.map { $0.toDomain() }, main: main?.toDomain(), location: Location(latitude: lat!, longitude: lon!), tempMin: tempMin, tempMax: tempMax)
    }
}

extension WeatherInformationDTO {
    func toDomain() -> WeatherInformationEntity {
        return .init(id: id, main: main, description: description, icon: icon)
    }
}

extension TemperatureInformationDTO {
    func toDomain() -> TempEntity {
        return .init(temp: temp)
    }
}
