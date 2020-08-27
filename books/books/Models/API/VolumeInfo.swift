//
//  VolumeInfo.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation

class VolumInfo: Decodable {
    var title: String = ""
    var authors: [String]?
    var description: String = ""
    var imageLink: ImageLink?
    var subtitle: String = ""
    var language: String = ""
    
    enum CodingKeys : String , CodingKey{
       
        case title = "Title"
        case authors = "Authors"
        case description = "Description"
        case imageLink = "ImageLink"
        case subtitle = "Subtitle"
        case language = "Language"
        
    }
    
     init(title: String, authors: [String], description: String, imageLink: String, subtitle: String, language: String) {
        self.title = title
        self.authors = authors
        self.description = description
        self.imageLink = ImageLink(thumbnailURL: imageLink)
        self.subtitle = subtitle
        self.language = language
    }
    
     required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        
        self.authors = try valueContainer.decode([String].self, forKey: CodingKeys.authors)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.imageLink = try valueContainer.decode(ImageLink.self, forKey: CodingKeys.imageLink)
        self.subtitle = try valueContainer.decode(String.self, forKey: CodingKeys.subtitle)
        self.language = try valueContainer.decode(String.self, forKey: CodingKeys.language)
    }
}
