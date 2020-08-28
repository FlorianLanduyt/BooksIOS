//
//  SearchBookCell.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit

class SearchBookCell: UITableViewCell {
    
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookCover: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(book : Book
//        , image : UIImage
    ){
        bookTitle.numberOfLines = 0
        bookTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        bookTitle.text = book.volumeInfo?.title
        //bookCover.image = image
    }
}
