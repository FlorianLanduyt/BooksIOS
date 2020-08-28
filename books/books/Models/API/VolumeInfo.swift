//
//  VolumeInfo.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation

class VolumInfo: Decodable {
    var title: String? = ""
    var authors: [String]
    var description: String?
    var string: String? = ""
    var imageLink: ImageLink?
    var subtitle: String? = ""
    var language: String? = ""
    
    enum CodingKeys : String , CodingKey{
       
        case title = "title"
        case authors = "authors"
        case description = "description"
        case imageLinks = "imageLinks"
        case subtitle = "subtitle"
        case language = "language"
        
    }
    
     init(title: String, authors: [String], description: String?, imageLink: ImageLink, subtitle: String, language: String) {
        self.title = title
        self.authors = authors
        self.description = description
        self.imageLink = imageLink
        self.subtitle = subtitle
        self.language = language
    }
    
     required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String?.self, forKey: CodingKeys.title)
        self.authors = try valueContainer.decode([String].self, forKey: CodingKeys.authors)
        self.imageLink = try valueContainer.decode(ImageLink.self, forKey: CodingKeys.imageLinks)

        
        let description = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.description)
        let subtitle = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.subtitle)
        let language = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.language)
        
        if let description = description {
            self.description = description
        }
        
        if let subtitle = subtitle {
            self.subtitle = subtitle
        }
        
        if let language = language {
            self.language = language
        }
        
        if let imageLink = imageLink {
            self.imageLink = imageLink
        }
        
        
    }
}
