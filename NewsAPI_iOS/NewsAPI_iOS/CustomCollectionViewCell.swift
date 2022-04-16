//
//  CustomCollectionViewCell.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-04-16.
//

import UIKit


class countryCell: UICollectionViewCell {
    
    @IBOutlet weak var textlabel: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
    }
}


class categoryCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
    }
}
