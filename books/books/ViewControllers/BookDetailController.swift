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
    
    @IBOutlet var removeFavorite: UIImageView!
    
    var book : Book? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        removeFavorite.isUserInteractionEnabled = true
        removeFavorite.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        DatabaseController.sharedInstance.inFavorites(id: book!.id, completion: { (bool) in
            if(bool){
                self.removeBook()
            } else {
                self.addBook()
            }
        })
    }
    
    func updateUI(){
        if let book = book {
            DatabaseController.sharedInstance.inFavorites(id: book.id, completion: { (bool) in
                if(bool){
                    self.setHeartFilled()
                } else {
                    self.setHeartEmpty()
                }
            })
            self.bookCover.kf.indicatorType = .activity
            self.bookCover.kf.setImage(with: URL(string: book.volumeInfo!.imageLink!.thumbnailURL!))
            
            self.bookTitle.numberOfLines = 0
            self.bookTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.bookTitle.text = book.volumeInfo?.title
            
            
            bookDescription.numberOfLines = 0
            bookDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            let bookDescription = book.volumeInfo?.description
            if let bookDescription = bookDescription {
                 self.bookDescription.text = bookDescription
            } else {
                self.book?.volumeInfo?.description = "Geen beschrijving gevonden van dit boek."
                self.bookDescription.text = "Geen beschrijving gevonden van dit boek."
            }
            
           
        }
    }
    
    private func removeBook(){
        DatabaseController.sharedInstance.removeBook(book: self.book!.toBookEntity(), completion: {(error) in
            if(error == nil){
                self.setHeartEmpty()
                self.view.makeToast("Boek verwijderd uit favorieten", duration: 2.0, position: .bottom)
                
            } else {
                self.somethingWrongToast()
            }
        })
    }
    
    private func addBook(){
        DatabaseController.sharedInstance.insertBook(book: self.book!.toBookEntity(), completion: { (error) in
            if(error == nil){
                self.setHeartFilled()
                self.view.makeToast("Boek toegevoegd aan favorieten", duration: 2.0, position: .bottom)
                
            } else {
                self.somethingWrongToast()
            }
        })
    }
    
    
    private func setHeartEmpty() {
        self.removeFavorite.image = UIImage(systemName: "heart")
    }
    
    private func setHeartFilled() {
        self.removeFavorite.image = UIImage(systemName: "heart.fill")
    }
    
    private func somethingWrongToast(){
        self.view.makeToast("Er is iets mis gelopen, probeer opnieuw", duration: 2.0, position: .bottom)
    }
    
}
