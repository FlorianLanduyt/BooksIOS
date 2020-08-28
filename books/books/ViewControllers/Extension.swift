//
//  Extension.swift
//  books
//
//  Created by Florian Landuyt on 28/08/2020.
//  Copyright © 2020 Florian Landuyt. All rights reserved.
//

import Foundation
import UIKit


//SOURCE: https://medium.com/@mtssonmez/handle-empty-tableview-in-swift-4-ios-11-23635d108409
extension UITableView{
    func setEmptyView(message : String){
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageLabel = UILabel()
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        
        emptyView.addSubview(messageLabel)
        
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
