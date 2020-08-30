//
//  HomeBookCell.swift
//  books
//
//  Created by Florian Landuyt on 30/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift


class HomeBookCell: UICollectionViewCell {
    
    @IBOutlet var bookCover: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func update(with book : Book ){
        self.bookTitle.text = book.volumeInfo?.title
        self.bookTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        self.bookTitle.textColor = .label
        
        let thumbnailUrl = book.volumeInfo!.imageLink!.thumbnailURL
        
        if let thumbnailUrl = thumbnailUrl {
            let downloadURL: URL = URL(string: thumbnailUrl)!
            self.bookCover.kf.indicatorType = .activity
            self.bookCover.kf.setImage(with: downloadURL)
        } else {
            self.bookCover .image = UIImage(named: "NoPhoto")
        }
        
        self.bookCover.layer.cornerRadius = 15
        self.bookCover.clipsToBounds = true
        

        let outerStackView = UIStackView(arrangedSubviews: [self.bookCover, self.bookTitle])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        outerStackView.axis = .vertical
        contentView.addSubview(outerStackView)

        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    

}
