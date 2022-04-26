//
//  NetworkService.swift
//  Weather
//
//  Created by Vladislav on 25.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func requestCoordinats(city: String, completion: @escaping (Result<Data, Error>) -> Void)
    func requestCityWeater(lat: String, lon: String ,completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "7bac02e74d8d23fc1a768e0a1888b1d6"
    
    enum NetworkErrors: Error {
        case failedToGetUrl
        case failedToGetData
    }

    func findRepositories(lat: String, lon: String) -> URL?{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/onecall"
        components.queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "exclude", value: "current,minutely,alerts"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon)
        ]
        let url = components.url
        return url
    }
    
    func requestCityWeater(lat: String, lon:String ,completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = findRepositories(lat: lat, lon: lon) else {
            completion(.failure(NetworkErrors.failedToGetUrl))
            return
        }
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data,
                  error == nil else {
                      completion(.failure(NetworkErrors.failedToGetData))
                      return
                  }
            completion(.success(data))
        }
        task.resume()
    }
    
    
    func requestCoordinats(city: String ,completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string:"http://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=\(apiKey)".encodeUrl) else {
            completion(.failure(NetworkErrors.failedToGetUrl))
            return
        }

        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data,
                  error == nil else {
                      completion(.failure(NetworkErrors.failedToGetData))
                      return
                  }
            completion(.success(data))
        }
        task.resume()
    }
}
