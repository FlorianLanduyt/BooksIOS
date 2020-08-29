//
//  BookDetailController.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit


class BookDetailController: UIViewController {

    @IBOutlet var bookCover: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookDescription: UILabel!
    
    var book : Book? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI(){
        if let book = book {
            self.bookCover.kf.indicatorType = .activity
            self.bookCover.kf.setImage(with: URL(string: book.volumeInfo!.imageLink!.thumbnailURL!))
            
            self.bookTitle.numberOfLines = 0
            self.bookTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.bookTitle.text = book.volumeInfo?.title
            

            bookDescription.numberOfLines = 0
            bookDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.bookDescription.text = book.volumeInfo?.description
        }
    }
    

}
