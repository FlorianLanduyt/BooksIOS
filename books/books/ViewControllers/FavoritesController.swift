
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
    
//    @IBOutlet var removeFavorite: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        //        removeFavorite.isUserInteractionEnabled = true
        //        removeFavorite.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    ////        let tappedImage = tapGestureRecognizer.view as! UIImageView
    //        let row = tableView.indexPathForSelectedRow?.row
    //
    //        DatabaseController.sharedInstance.removeBook(book: books![row!], completion: { (error) in
    //        if(error == nil){
    //            self.view.makeToast("Boek toegevoegd aan favorieten", duration: 2.0, position: .bottom)
    //        } else {
    //            self.view.makeToast("Er is iets mis gelopen, probeer opnieuw", duration: 2.0, position: .bottom)
    //        }
    //
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        DatabaseController.sharedInstance.getAll(completion: {
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
            
            DatabaseController.sharedInstance.removeBook(book: books![indexPath.row], completion: { (error) in
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
