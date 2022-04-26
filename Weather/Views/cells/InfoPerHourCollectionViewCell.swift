//
//  InfoPerHourCollectionViewCell.swift
//  Weather
//
//  Created by Vladislav on 25.04.2022.
//

import UIKit

class InfoPerHourCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configureCell(model: Hourly) {
        hourLabel.text = "22"
        tempLabel.text = "\(Int(model.temp))℃"
        weatherImage.image = UIImage(named: model.weather[0].icon)
        hourLabel.text = "\(model.dt)"
    }
}
