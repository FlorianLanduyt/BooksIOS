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
            try realm.write {
                realm.delete(book)
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
}

