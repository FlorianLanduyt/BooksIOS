//
//  BookResponse.swift
//  books
//
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation


class BookResponse : Decodable{
    var totalItems: Int
    var books : [Book]
    
    enum CodingKeys : String, CodingKey{
        case totalItems = "totalItems"
        case books = "items"
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.totalItems = try valueContainer.decode(Int.self, forKey: CodingKeys.totalItems)
        self.books = try valueContainer.decode([Book].self, forKey: CodingKeys.books)
        
        
    }
}
