//
//  CityPresenter.swift
//  Weather
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
protocol CityPresenterProtocol: AnyObject {
    func didOpenNewPage(lat: String, lon: String)
}

class CityPresenter: CityPresenterProtocol {
    
    weak var view: CityInput!
    var networkService: NetworkServiceProtocol!
    
    ///json decode and formatting date
    func didOpenNewPage(lat: String, lon: String) {
        networkService.requestCityWeater(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        var model = try JSONDecoder().decode(CityWeather.self, from: data)
                        model.hourly = Array(model.hourly.prefix(24))
                        model.daily = Array(model.daily.prefix(7))
                        
                        
                        let calendar = Calendar.current
                        for i in 0 ..< model.hourly.count {
                            let date = NSDate(timeIntervalSince1970: TimeInterval(model.hourly[i].dt))
                            model.hourly[i].dt = calendar.component(.hour, from: date as Date)
                        }
                        for i in 0 ..< model.daily.count {
                            let date = NSDate(timeIntervalSince1970: TimeInterval(model.daily[i].dt))
                            model.daily[i].dt = calendar.component(.day, from: date as Date)
                        }
                        self?.view.configureNewPage(model: model)
                    } catch {
                        print("Error with decode")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
