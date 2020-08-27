//
//  Book.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation

class Book: Decodable {
    var id: String = ""
    var volumeInfo: VolumInfo
    
    enum CodingKeys : String, CodingKey{
        case id = "Id"
        case volumeInfo = "VolumeInfo"
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(String.self, forKey: CodingKeys.id)
        self.volumeInfo = try valueContainer.decode(VolumInfo.self, forKey: CodingKeys.volumeInfo)
    }
}
