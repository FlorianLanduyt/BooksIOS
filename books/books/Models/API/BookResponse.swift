//
//  BookResponse.swift
//  books
//
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation


class BookResponse : Decodable{
    var totalItems: String?
    var books : [Book]
    
    enum CodingKeys : String, CodingKey{
        case totalItems
        case books = "Books"
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.totalItems = try valueContainer.decode(String.self, forKey: CodingKeys.totalItems)
        self.books = try valueContainer.decode([Book].self, forKey: CodingKeys.books)
    }
}
