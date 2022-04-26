//
//  ViewController.swift
//  Weather
//
//  Created by Vladislav on 25.04.2022.
//

import UIKit

protocol CityInput: AnyObject {
    func configureNewPage(model: CityWeather)
}

class CityWeatherViewController: UIViewController, CityInput {

    @IBOutlet weak var collectionHourInfo: UICollectionView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var tableViewDaysInfo: UITableView!
    
    var output: CityPresenterProtocol!
    
    var model = CityWeather()
    var lat: String = ""
    var lon: String = ""
    var name: String = ""
    
    static func makeMemeDetailVC(name: String, lat: String, lon: String) -> CityWeatherViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityWeatherViewController") as! CityWeatherViewController
        vc.name = name
        vc.lon = lon
        vc.lat = lat
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = name
        output.didOpenNewPage(lat: lat, lon: lon)
        collectionHourInfo.register(UINib(nibName: "InfoPerHourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InfoPerHourCollectionViewCell")
        collectionHourInfo.dataSource = self
        collectionHourInfo.layer.cornerRadius = 10
        tableViewDaysInfo.register(UINib(nibName: "dailyInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "dailyInfoTableViewCell")
        tableViewDaysInfo.dataSource = self
        tableViewDaysInfo.layer.cornerRadius = 10
    }
    
    func configureNewPage(model: CityWeather) {
        self.model = model
        tableViewDaysInfo.reloadData()
        collectionHourInfo.reloadData()
        temperatureLabel.text = "\(Int(model.hourly[0].temp))℃"
        descriptionWeatherLabel.text = model.daily[0].weather[0].description
        minMaxTemperatureLabel.text = "Макс: \(Int(model.daily[0].temp.max))℃, Мин: \(Int(model.daily[0].temp.max))℃"
    }
}

//MARK: - CollectionView

extension CityWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.hourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionHourInfo.dequeueReusableCell(withReuseIdentifier: "InfoPerHourCollectionViewCell", for: indexPath) as! InfoPerHourCollectionViewCell
        cell.configureCell(model: model.hourly[indexPath.row])
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return cell
    }
}

//MARK: - TableView

extension CityWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.daily.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewDaysInfo.dequeueReusableCell(withIdentifier: "dailyInfoTableViewCell", for: indexPath) as! dailyInfoTableViewCell
        cell.configureCell(model: model.daily[indexPath.row])
        return cell
    }
}
