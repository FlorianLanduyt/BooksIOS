//
//  BookDetailController.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import Toast_Swift


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
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        DatabaseController.sharedInstance.insertBook(book: self.book!.toBookEntity(), completion: { (error) in
        if(error == nil){
            self.view.makeToast("Boek toegevoegd aan favorieten", duration: 2.0, position: .bottom)
        } else {
            self.view.makeToast("Er is iets mis gelopen, probeer opnieuw", duration: 2.0, position: .bottom)
        }
    })
    }
}
