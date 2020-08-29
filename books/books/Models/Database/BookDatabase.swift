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
    @objc dynamic var authors: String = ""
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
        self.descript = descript
        self.imageLink = imageLink
        self.subtitle = subtitle
        self.language = language
        
        
        var res = ""
        
        let authorsList = authors
        if let authorsList = authorsList {
            authorsList.forEach{ a in
                res.append(a)
                res.append(", ")
            }
        }
        res.removeLast(2)
        self.authors = res

        
    }
    
    func toApiBook() -> Book {
        let authorsList = self.authors.split(separator: ",")
        var authorsArray: [String] = []
        
        for author in authorsList {
            let a = author.trimmingCharacters(in: .whitespacesAndNewlines)
            authorsArray.append(String(a))
        }
        
        let imageLink = ImageLink(thumbnailURL: self.imageLink)

        let volumeInfo: VolumInfo =
            VolumInfo(
                title:self.title,
                authors: authorsArray,
                description: self.descript,
                imageLink: imageLink,
                subtitle: self.subtitle,
                language: self.language)


        return Book(
            id: self.id,
            volumeInfo: volumeInfo
        )
    }
}

