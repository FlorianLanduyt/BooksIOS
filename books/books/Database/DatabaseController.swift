//
//  DatabaseController.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation
import RealmSwift


class DatabaseController {
    static let sharedInstance = DatabaseController()
    
    init(){
        let config = Realm.Configuration(
            schemaVersion: 1
        )
        Realm.Configuration.defaultConfiguration = config
    }
    
    func insertBook(book: BookEntity, completion: @escaping(Error?) -> Void){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(book, update: .modified)
            }
        } catch let error {
            print("something went wrong")
            completion(error)
        }
        completion(nil)
    }
    
    func inFavorites(id : String, completion: @escaping(Bool) -> Void){
        do{
            let realm = try! Realm()
            
            guard realm.object(ofType: BookEntity.self, forPrimaryKey: id) != nil else
            {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func getAll(completion: @escaping(Results<BookEntity>?) -> Void){
        let books: Results<BookEntity>;
        do{
            let realm = try Realm()
            books = realm.objects(BookEntity.self)
            completion(books)
        } catch {
            print("something went wrong: " + error.localizedDescription)
            completion(nil)
        }
    }
    
    func removeBook(book: BookEntity, completion: @escaping(Error?) -> Void){
        do{
            let realm = try Realm()
            
            let bookToRemove: BookEntity? = realm.object(ofType: BookEntity.self, forPrimaryKey: book.id)
            if let bookToRemove = bookToRemove {
                try realm.write {
                    realm.delete(bookToRemove)
                }
            }
        } catch let error {
            print("something went wrong")
            completion(error)
        }
        
        completion(nil)
    }
    func removeAllBooks(completion: @escaping(Error?) -> Void){
        do{
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print("something went wrong")
            completion(error)
        }
        
        completion(nil)
    }
    
    func addRating(book: BookEntity, completion: @escaping(Error?) -> Void){
        do {
            let realm = try! Realm()
            try realm.write{
                //check if the movieSerieDetail is in the database will be done in the viewController
                let bookFromDb = realm.object(ofType: BookEntity.self, forPrimaryKey: book.id)
                if let bookFromDb = bookFromDb {
                    bookFromDb.rating = book.rating
                    realm.add(bookFromDb, update: .modified)
                } else {
                    realm.add(book, update: .modified)
                }
            }
            completion(nil)
        } catch let error as NSError{
            completion(error)
        }
    }
    
    func getRating(bookId: String, completion: @escaping(Int?) -> Void){
        do {
            let realm = try! Realm()
            
            //check if the movieSerieDetail is in the database will be done in the viewController
            let bookFromDb = realm.object(ofType: BookEntity.self, forPrimaryKey: bookId)
            guard let bookFromDbNotNull = bookFromDb else {
                completion(nil)
                return
            }
            
            completion(bookFromDbNotNull.rating)
        }
    }

}
