//
//  SearchBookCell.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift


class SearchBookCell: UITableViewCell {
    
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookCover: UIImageView!
    @IBOutlet var authors: UILabel!

    @IBOutlet var starButtons: [UIButton]!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(book : Book ){
        bookTitle.numberOfLines = 0
        bookTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        bookTitle.text = book.volumeInfo?.title
        
        let thumbnailUrl = book.volumeInfo!.imageLink!.thumbnailURL
        
        if let thumbnailUrl = thumbnailUrl {
            let downloadURL: URL = URL(string: thumbnailUrl)!
            self.bookCover.kf.indicatorType = .activity
            self.bookCover.kf.setImage(with: downloadURL)
        } else {
            self.bookCover .image = UIImage(named: "NoPhoto")
        }
        
        self.authors.numberOfLines = 0
        
        var res: String = ""
        book.volumeInfo!.authors.forEach{ a in
            res.append(a)
            res.append(", ")
        }
        
        res.removeLast(2)
        
        self.authors.text = res
        
        getRatingUI(book: book)
    }
    
    private func getRatingUI(book: Book){
        DatabaseController.sharedInstance.getRating(bookId: book.id, completion:{ (rating) in
            if (rating == nil){
                return
            } else {
                self.setRatingUI(rating: rating!)
            }
        })
    }
    
    private func setRatingUI(rating: Int){
        if let starButtons = self.starButtons {
            for button in starButtons {
                if button.tag <= rating{
                    button.setTitle("★", for: .normal)
                } else {
                     button.setTitle("☆", for: .normal)
                }
            }
        }
        
    }
    
    
}
