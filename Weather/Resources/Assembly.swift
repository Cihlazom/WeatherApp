//
//  Assembly.swift
//  Weather
//
//  Created by Vladislav on 25.04.2022.
//

import UIKit

class Assembly: NSObject {
    @IBOutlet weak var mainPageViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = mainPageViewController as? MainPageViewController else { return }
        
        let mainPresenter = MainPresenter()
        
        let networkService = NetworkService()
        let dataService = CoreDataManager()
        
        view.output = mainPresenter
        
        mainPresenter.view = view
        mainPresenter.networkService = networkService
        mainPresenter.dataService = dataService
    }
}

class CityAssembly: NSObject {

    @IBOutlet weak var cityWeatherViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let cityView = cityWeatherViewController as? CityWeatherViewController else { return }
        
        let cityPresenter = CityPresenter()
        
        let networkService = NetworkService()
        
        cityView.output = cityPresenter
        
        cityPresenter.view = cityView
        cityPresenter.networkService = networkService

    }
}
