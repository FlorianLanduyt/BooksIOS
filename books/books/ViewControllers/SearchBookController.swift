//
//  SearchBookController.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import Reachability

// When there is nog book to show --> empty view with message
//SOURCE: https://medium.com/@mtssonmez/handle-empty-tableview-in-swift-4-ios-11-23635d108409
class SearchBookController: UITableViewController , UISearchResultsUpdating{
    var books : [Book] = []
    let reachability = try! Reachability()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchbarInNavbar()
        self.tableView.rowHeight = 120
    }
    
    func setSearchbarInNavbar(){
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        self.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
           if let inputText = searchController.searchBar.text{
               
               guard !inputText.isEmpty else{
                   self.books.removeAll()
                   self.tableView.reloadData()
                   return
               }
            getBooks(inputText)
           }
       }
    
    fileprivate func getBooks(_ inputText: String) {
        NetworkController.sharedInstance.getBooks(searchQuery: inputText, completion: {
            (fetchedResult) in
            guard let fetchedResult = fetchedResult else {
                return
            }
            self.books = fetchedResult.books
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.books.count == 0){
            self.tableView.setEmptyView(message: "Geef titel van boek in")
        } else {
            tableView.restore()
        }
        return self.books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! SearchBookCell
        let book = books[indexPath.row]
        cell.update(book: book)
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailController,
            let row = tableView.indexPathForSelectedRow?.row {
            destination.book = books[row]
        }
    }

}
