//
//  BookDatabase.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation

import RealmSwift

class BookEntity : Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var authors: [String]? = nil
    @objc dynamic var descript: String = ""
    @objc dynamic var imageLink: String = ""
    @objc dynamic var subtitle: String = ""
    @objc dynamic var language: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init(){
        super.init()
    }
    
    init(id:String, title: String, authors: [String]?, descript: String, imageLink: String, subtitle: String,language: String ) {
        self.id = id
        self.title = title
        self.authors = authors
        self.descript = descript
        self.imageLink = imageLink
        self.subtitle = subtitle
        self.language = language
        
    }
    
//    func toApiBook() -> Book {
//
//        let volumeInfo: VolumInfo =
//            VolumInfo(
//                title:self.title,
//                authors: self.authors!,
//                description: self.descript,
//                imageLink: self.imageLink,
//                subtitle: self.subtitle,
//                language: self.language)
//
//
//        return Book(
//            id: self.id,
//            volumeInfo: volumeInfo
//        )
//    } 
}

