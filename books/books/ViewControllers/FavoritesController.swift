
//
//  FavoritesController.swift
//  books
//
//  Created by Florian Landuyt on 29/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit

import RealmSwift
import Toast_Swift

class FavoritesController: UITableViewController {
    
    var books : Results<BookEntity>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        DatabaseController.sharedInstance.getFavorites(completion: {
            (books) in
            self.books = books
            self.updateTable()
        })
        
    }
    
    func updateTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let books = books {
            if(books.count == 0){
                self.view.makeToast("Voeg een boek toe", position: .center)
            }
            return books.count
        } else {
            
            return 0
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! SearchBookCell
        if let books = books {
            cell.update(book: books[indexPath.row].toApiBook())
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = books![indexPath.row].toApiBook()
            book.inFavorites = false
            
            DatabaseController.sharedInstance.addBookToFavorites(book: book.toBookEntity(), completion: { (error) in
                if(error == nil){
                    self.view.makeToast("Boek verwijderd uit favorieten", duration: 2.0, position: .bottom)
                } else {
                    self.view.makeToast("Er is iets mis gelopen, probeer opnieuw", duration: 2.0, position: .bottom)
                }
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailController,
            let row = tableView.indexPathForSelectedRow?.row {
            destination.book = books![row].toApiBook()
        }
    }
    
    
}
