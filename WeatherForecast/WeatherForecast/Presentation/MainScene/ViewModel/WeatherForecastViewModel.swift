//
//  WeatherForecastViewModel.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/04/03.
//

import Foundation

import CoreLocation

final class WeatherForecastViewModel {
    
    private let usecase: WeatherForecastUseCase
    
    var weatherInfo: WeatherEntity?
    var forecastInfo = [ForecastListEntity]()
    
    var loadWeatherEntity: ((Result<WeatherEntity, Error>) -> Void)?
    var loadForecastEntity: ((Result<ForecastEntity, Error>) -> Void)?
    
    var temperature: String {
        let tempMin = formatter(temp: weatherInfo?.tempMin ?? 0.0)
        let tempMax = formatter(temp: weatherInfo?.tempMax ?? 0.0)
        return "최저 \(tempMin) 최고 \(tempMax)"
    }
    
    var currentTemperature: String {
        let mainTemp = formatter(temp: weatherInfo?.main?.temp ?? 0.0)
        return mainTemp
    }
    
    init(usecase: WeatherForecastUseCase) {
        self.usecase = usecase
    }
}

extension WeatherForecastViewModel {
    
    func formatter(temp: Double) -> String {
        let str = String(format: "%.1f", temp)
        return str + "°"
    }
    
    func formatterDate(date: String) -> String {
        let dateStr = date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:SS"

        let convertDate = dateFormatter.date(from: dateStr)

        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM/dd(EEEEE) HH시"
        myDateFormatter.locale = Locale(identifier: "ko_KR")
        let convertStr = myDateFormatter.string(from: convertDate!)
        return convertStr
    }

    // location manger로 옮기기
    func getLocationString(completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: weatherInfo?.location?.latitude ?? 0.0, longitude: weatherInfo?.location?.longitude ?? 0.0)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [weak self] placemarks, _ in
            guard let placemarks = placemarks,
                  let address = placemarks.last
            else {
                completion("")
                return
            }
            completion("\(address.locality ?? "") \(address.subLocality ?? "")")
            return
        }
    }
}

extension WeatherForecastViewModel {
    
    func requestWeatherData() {
        usecase.getWeather { [weak self] result in
            self?.loadWeatherEntity?(result.map { weatherEntity in
                self?.weatherInfo = weatherEntity
                return weatherEntity
            })
        }
    }
    
    func requestForecastData() {
        usecase.getForecast { [weak self] result in
            self?.loadForecastEntity?(result.map { forecastEntity in
                self?.forecastInfo = forecastEntity.list
                return forecastEntity
            })
        }
    }
}
