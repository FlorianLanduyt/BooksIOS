//
//  RatingController.swift
//  books
//
//  Created by Florian Landuyt on 30/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import RealmSwift


class RatingController: UITableViewController {
    
    var books : Results<BookEntity>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DatabaseController.sharedInstance.getBooksWithRating(completion: {
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let books = books {
            if(books.count == 0){
                self.view.makeToast("Voeg een rating toe", position: .center)
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailController,
            let row = tableView.indexPathForSelectedRow?.row {
            destination.book = books![row].toApiBook()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            setRatingToZero(indexPath)
        }
    }
    
    fileprivate func setRatingToZero(_ indexPath: IndexPath) {
        let book = books![indexPath.row].toApiBook()
        book.rating = 0
        
        DatabaseController.sharedInstance.addRating(book: book.toBookEntity(), completion: { (error) in
            if(error == nil){
                self.view.makeToast("rating verwijderd van het boek", duration: 2.0, position: .center)
            } else {
                self.view.makeToast("Er is iets mis gelopen, probeer opnieuw", duration: 2.0, position: .center)
            }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   
    

}
