//
//  ImageLink.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation

class ImageLink: Decodable {
    var thumbnailURL: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail"
    }
    
    init(thumbnailURL: String) {
        self.thumbnailURL = thumbnailURL
    }
    
     required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.thumbnailURL = try valueContainer.decode(String.self, forKey: CodingKeys.thumbnailURL)
    }
    
    
}
