//
//  newsCardTableViewCell.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-03-25.
//


import UIKit

class newsCardTableViewCell: UITableViewCell {

    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var newsArticleImage: UIImageView!
    @IBOutlet weak var newsArticleTitle: UILabel!
    @IBOutlet weak var newsArticlePublishedDate: UILabel!
    @IBOutlet weak var newsArticleAuthor: UILabel!
    @IBOutlet weak var newsArticleDesc: UILabel!
    @IBOutlet weak var newsArticleContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }
    
    func setupUI() {
        
        //Super View Setup UI
        superView.layer.cornerRadius = 24
        superView.layer.shadowColor = UIColor.black.cgColor
        superView.layer.shadowRadius = 4
        superView.layer.shadowOpacity = 0.1
        superView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        //newsArticleCard
        newsArticleImage.layer.cornerRadius = 24
        newsArticleImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

