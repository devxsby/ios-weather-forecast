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
    private let coreLocationManager = CoreLocationManager()

    var weatherInfo: WeatherEntity?
    var forecastInfo = [ForecastListEntity]()

//    var mainLocation: String {
//        getLocationString { location in
//
//        }
//    }

    var temperature: String {
        let tempMin = formatter(temp: weatherInfo?.tempMin ?? 0.0)
        let tempMax = formatter(temp: weatherInfo?.tempMax ?? 0.0)
        return "최저 \(tempMin) 최고 \(tempMax)"
    }

    var currentTemperature: String {
        let mainTemp = formatter(temp: weatherInfo?.main?.temp ?? 0.0)
        return mainTemp
    }
    
    var loadWeatherEntity: ((WeatherEntity) -> Void)?
    var loadForecastEntity: ((ForecastEntity) -> Void)?
    
    init(usecase: WeatherForecastUseCase) {
        self.usecase = usecase
        self.updateCurrentLocation()
    }
    
    private func updateCurrentLocation() {
        coreLocationManager.delegate = self
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

    func formatter(temp: Double) -> String {
        let str = String(format: "%.1f", temp)
        return str + "°"
    }

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
    
    func requestWeatherData(lat: Double, lon: Double) {
        usecase.fetchWeather(lat: lat, lon: lon) { [weak self] weatherEntity in
            self?.weatherInfo = weatherEntity
            self?.loadWeatherEntity?(weatherEntity)
        }
    }
    
    func requestFetchData(lat: Double, lon: Double) {
        usecase.fetchForecast(lat: lat, lon: lon) { [weak self] forecastEntity in
            self?.forecastInfo = forecastEntity.list
            self?.loadForecastEntity?(forecastEntity)
        }
    }
}

// MARK: - LocationUpdateDelegate Implementation

extension WeatherForecastViewModel: LocationUpdateDelegate {
    
    func locationDidUpdateToLocation(location: Location) {
        let lat = location.latitude
        let lon = location.longitude
        self.requestWeatherData(lat: lat, lon: lon)
        self.requestFetchData(lat: lat, lon: lon)
    }
}
