//
//  HomeController.swift
//  books
//
//  Created by Florian Landuyt on 30/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import UIKit
import RealmSwift


// Got the idea to use a collection instead of tableview from
// https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/

extension UICollectionView {
    
    var centerPoint : CGPoint {
        
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
}


class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var collectionViewFavorites: UICollectionView!
    @IBOutlet var collectionViewRated: UICollectionView!
    
    
    private var favoriteBooks : Results<BookEntity>?
    private var ratedBooks : Results<BookEntity>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewRated.delegate = self
        collectionViewRated.dataSource = self
        
        collectionViewFavorites.delegate = self
        collectionViewFavorites.dataSource = self
        
        self.view.addSubview(collectionViewFavorites)
        self.view.addSubview(collectionViewRated)
        
        collectionViewFavorites.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewFavorites.backgroundColor = .systemBackground
        
        collectionViewRated.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewRated.backgroundColor = .systemBackground
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        DatabaseController.sharedInstance.getFavorites(completion: {
            (favorites) in
            self.favoriteBooks = favorites
            self.updateCollection()
        })
        
        DatabaseController.sharedInstance.getBooksWithRating(completion: {
            (ratedBooks) in
            self.ratedBooks = ratedBooks
            self.updateCollection()
        })
    }
    
    func updateCollection(){
        DispatchQueue.main.async {
            self.collectionViewFavorites.reloadData()
            self.collectionViewRated.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewFavorites {
            if let favoriteBooks = favoriteBooks {
                if(favoriteBooks.count == 0){
                    self.view.makeToast("Voeg een boek toe aan favorieten!", position: .center)
                }
                return favoriteBooks.count
            } else {
                return 0
            }
        }
        
        
        if let ratedBooks = ratedBooks {
            if(ratedBooks.count == 0){
                self.view.makeToast("Voeg rating toe aan een boek!", position: .bottom)
            }
            return ratedBooks.count
        } else {
            return 0
        }
        
        
    }
    
    
    func numberOfSectionsInFavorites(collectionView: UICollectionView) ->Int {
        return 1
    }
    
    func numberOfSectionsInRatedBooks(collectionView: UICollectionView) ->Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewFavorites {
            let cellFavorites = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeBookCell
            
            if let favoriteBooks = favoriteBooks {
                cellFavorites.update(with: favoriteBooks[indexPath.row].toApiBook())
            }
            return cellFavorites
        } else {
            let cellRated = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeBookCell
            
            if let ratedBooks = ratedBooks {
                cellRated.update(with: ratedBooks[indexPath.row].toApiBook())
            }
            
            
            return cellRated
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "favoritesToDetail", sender: self)
        if collectionView == self.collectionViewFavorites {
            let detailController = storyboard?.instantiateViewController(identifier: "details") as? BookDetailController
            detailController?.book = favoriteBooks![indexPath.row].toApiBook()
            self.navigationController?.pushViewController(detailController!, animated: true)
        } else {
            let detailController = storyboard?.instantiateViewController(identifier: "details") as? BookDetailController
            detailController?.book = ratedBooks![indexPath.row].toApiBook()
            self.navigationController?.pushViewController(detailController!, animated: true)
        }
    }
    
    
}




