//
//  NetworkService.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/03/20.
//

import Foundation

// MARK: - Protocols

protocol NetworkServiceProtocol {
    typealias APICompletion<T> = (Result<T, NetworkError>) -> Void
    
    func fetchWeather(lat: String, lon: String, completion: @escaping APICompletion<WeatherResponseDTO>)
    func fetchForecast(lat: String, lon: String, completion: @escaping APICompletion<ForecastResponseDTO>)
}

// MARK: - NetworkService

class NetworkService: NetworkServiceProtocol {

    func fetchWeather(lat: String, lon: String, completion: @escaping APICompletion<WeatherResponseDTO>) {
        request(lat: lat, lon: lon, path: NetworkConfig.URLPath.weather.rawValue, completion: completion)
    }

    func fetchForecast(lat: String, lon: String, completion: @escaping APICompletion<ForecastResponseDTO>) {
        request(lat: lat, lon: lon, path: NetworkConfig.URLPath.forecast.rawValue, completion: completion)
    }
}

// MARK: - Methods

extension NetworkServiceProtocol {
    func request<T: Decodable> (lat: String, lon: String, path: String, completion: @escaping APICompletion<T>) {

        guard let url = makeURL(path: path, lat: lat, lon: lon) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.transportError))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }

            guard let safeData = data else {
                completion(.failure(.missingData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: safeData)
                completion(.success(decodedData))
                return
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }.resume()
    }

//    func requestImage(id: Int, completion: @escaping (UIImage) -> Void) {
//
//        let icon: String?
//
//        switch id {
//        case 200...232:
//            return "11d"
//        case 300...321, 520...531:
//            return "09d"
//        case 500...504:
//            return "10d"
//        case 511, 600...622:
//            return "13d"
//        case 701...781:
//            return "50d"
//        case 800:
//            return "01d" or "01n"
//        case 801:
//            return "02d" or "02n"
//        case 802:
//            return "03d" or "03n"
//        case 803:
//            return "04d" or "04n"
//        case 804:
//            return "04d" or "04n"
//        default:
//            return ""
//        }
//
//        let url2 = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
//
//        var request = URLRequest(url: url2)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: url2) { data, response, error in
//            guard error == nil else {
//                completion(.failure(.transportError))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,
//                  (200...299).contains(response.statusCode) else {
//                completion(.failure(.serverError))
//                return
//            }
//
//            guard let safeData = data else {
//                completion(.failure(.missingData))
//                return
//            }
//
//            do {
//                let decodedData = try JSONDecoder().decode(T.self, from: safeData)
//                completion(.success(decodedData))
//                return
//            } catch {
//                completion(.failure(.decodingError))
//                return
//            }
//        }.resume()
//    }

    func makeURL(path: String, lat: String, lon: String) -> URL? {
        
        var urlComponents = URLComponents(string: "\(NetworkConfig.baseURL)/\(path)")
        
        let latQuery = URLQueryItem(name: "lat", value: lat)
        let lonQuery = URLQueryItem(name: "lon", value: lon)
        let appIdQuery = URLQueryItem(name: "appid", value: SecretKey.appId)
        let unitsQuery = URLQueryItem(name: "units", value: "metric")
        let langQuery = URLQueryItem(name: "lang", value: "kr")
        
        urlComponents?.queryItems = [latQuery, lonQuery, appIdQuery, unitsQuery, langQuery]
        
        return urlComponents?.url
    }
}
