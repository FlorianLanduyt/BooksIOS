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
        
    @IBOutlet var starButtons: [UIButton]!
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        let tag = sender.tag
        
        self.setRatingUI(rating: tag)
        
        let tagToSet = sender.tag
        book?.rating = tagToSet
        
        self.addRatingToBook()
        
    }
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewWillLayoutSubviews(){
    super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 200, height: 600)
    }
    
    var book : Book? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        removeFavorite.isUserInteractionEnabled = true
        removeFavorite.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addRatingToBook(){
        DatabaseController.sharedInstance.addRating(book: self.book!.toBookEntity(), completion: { (error) in
            if(error == nil){
                self.view.makeToast("Rating toegevoegd aan boek", duration: 2.0, position: .bottom)
            } else {
                self.somethingWrongToast()
            }
        })
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
            
            self.getRatingUI()
            
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
    
    private func setRatingUI(rating: Int){
        for button in starButtons {
            if button.tag <= rating{
                button.setTitle("★", for: .normal)
            } else {
                 button.setTitle("☆", for: .normal)
            }
        }
    }
    
    private func getRatingUI(){
        DatabaseController.sharedInstance.getRating(bookId: book!.id, completion:{ (rating) in
            if (rating == nil){
                return
            } else {
                self.setRatingUI(rating: rating!)
            }
        })
    }
    
    private func removeBook(){
        book?.inFavorites = false
        
        DatabaseController.sharedInstance.addBookToFavorites(book: self.book!.toBookEntity(), completion: {(error) in
            if(error == nil){
                self.setHeartEmpty()
                self.view.makeToast("Boek verwijderd uit favorieten", duration: 2.0, position: .bottom)
                
            } else {
                self.somethingWrongToast()
            }
        })
    }
    
    
    private func addBook(){
        book?.inFavorites = true
        
        DatabaseController.sharedInstance.addBookToFavorites(book: self.book!.toBookEntity(), completion: { (error) in
            if(error == nil){
                self.setHeartFilled()
                self.view.makeToast("Boek toegevoegd aan favorieten", duration: 2.0, position: .bottom)
                
            } else {
                self.somethingWrongToast()
            }
        })
    }
    
    @IBAction func shareBook(_ sender: Any) {
        let text = " \(String(describing: self.book!.volumeInfo!.title!)) is zeker de moeite om een te lezen!"
        
        let shareItems = [text] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareItems,applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController,animated: true,completion: nil)
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
