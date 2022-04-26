//
//  MainTableViewCell.swift
//  Weather
//
//  Created by Vladislav on 26.04.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(name: String) {
        nameLabel.text = name
        contentView.layer.cornerRadius = 20
        backgroundColor = .clear
    }
    
}
