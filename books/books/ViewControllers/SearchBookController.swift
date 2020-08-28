//
//  SearchBookController.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import Reachability


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
       }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.books.count == 0){
            self.tableView.setEmptyView(message: "No result for search")
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
        
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
