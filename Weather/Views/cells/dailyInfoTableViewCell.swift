//
//  dailyInfoTableViewCell.swift
//  Weather
//
//  Created by Vladislav on 26.04.2022.
//

import UIKit

class dailyInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayTemLabel: UILabel!
    @IBOutlet weak var nightTempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    func configureCell(model: Daily){
        dayTemLabel.text = "Днем \(Int(model.temp.day))℃"
        nightTempLabel.text = "Ночью \(Int(model.temp.night))℃"
        weatherImage.image = UIImage(named: model.weather[0].icon)
        
        let calendar = Calendar.current
        let date = Date()
        if calendar.component(.day, from: date) != model.dt {
            dayLabel.text = "\(model.dt)-ое"
        }
    }
    
}
