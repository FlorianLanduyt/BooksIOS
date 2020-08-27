//
//  NetworkController.swift
//  books
//
//  Created by Florian Landuyt on 27/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        return components?.url
    }
}

class NetworkController{
    // SOURCE: What is a singleton and how to create one in swift
    static let sharedInstance = NetworkController()
    
    let BASE_URL: String = "https://www.googleapis.com/books/v1/"
    
    func getBooks(searchQuery: String, completion: @escaping (BookResponse?) -> Void){
        let BASE_URL: String = "https://www.googleapis.com/books/v1/"
        let searchURL = URL(string: BASE_URL)
        let s = searchURL?.withQueries(["q":searchQuery])

        let task = URLSession.shared.dataTask(with: s!){
            (data, error, response) in
            if let data = data,
               let resp =  try? JSONDecoder().decode(BookResponse.self, from: data){
                completion(resp)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
