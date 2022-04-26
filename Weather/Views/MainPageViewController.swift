//
//  ViewController.swift
//  Weather
//
//  Created by Vladislav on 25.04.2022.
//

import UIKit

protocol ViewInput: AnyObject {
    func loadFromCoreData(cities: [City])
}

class MainPageViewController: UIViewController, ViewInput {
    
    var output: ViewOutput!
    var model = [City]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        output.mainPageLoaded()
        tableViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func tableViewSetup() {
        view.addSubview(tableView)
        tableView.backgroundView = UIImageView(image: UIImage(named: "back_weather"))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadFromCoreData(cities: [City]) {
        model = cities
        tableView.reloadData()
        if model.count == 0 {
            showAllert()
        }
    }
    
    private func showAllert() {
        let allertController = UIAlertController(title: "Добавьте город", message: "", preferredStyle: .alert)

        allertController.addTextField { textField in textField.placeholder = "Название города"}
        let createButton = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let cityName = allertController.textFields?[0].text else {
                return
            }
            self?.output.addNewCity(city: cityName)
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        allertController.addAction(cancelButton)
        allertController.addAction(createButton)
        self.present(allertController, animated: true, completion: nil)
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        showAllert()
    }
}

//MARK: - TableView

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        guard let name = model[indexPath.row].name else { return UITableViewCell()}
        cell.configureCell(name: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Добавьте нужный вам город город"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let name = model[indexPath.row].name,
              let lat = model[indexPath.row].lat,
              let lon = model[indexPath.row].lon else {
                  return
              }
        let vc = CityWeatherViewController.makeMemeDetailVC(name: name, lat: lat, lon: lon)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
