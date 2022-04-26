//
//  Presenter.swift
//  Weather
//
//  Created by Vladislav on 25.04.2022.
//

import Foundation

protocol ViewOutput: AnyObject {
    func addNewCity(city: String)
    func mainPageLoaded()
}

class MainPresenter: ViewOutput {

    weak var view: ViewInput!
    var networkService: NetworkServiceProtocol!
    var dataService: CoreDataManagerProtocol!

    
    func mainPageLoaded() {
        guard let cities = dataService.returnAllCities() else {
            return
        }
        view.loadFromCoreData(cities: cities)
    }
    
    func addNewCity(city: String) {
        networkService.requestCoordinats(city: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.decode(with: data, city: city)
                    self?.mainPageLoaded()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func decode(with data: Data, city: String) {
        do {
            let model = try JSONDecoder()
                .decode([Throwable<Geocoding>].self, from: data)
                .compactMap { try? $0.result.get() }
            print(model)
            dataService.addNewCity(name: city, lat: "\(model[0].lat)", lon: "\(model[0].lon)")
        } catch {
            print("Error with decode")
        }
    }
}

struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}

struct Geocoding: Codable {
    var lat: Double
    var lon: Double
}
