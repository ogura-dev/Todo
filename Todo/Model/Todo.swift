//
//  Todo.swift
//  Todo
//
//  Created by ogura on 2022/06/30.
//

import Firebase
import Foundation

struct Todo {
    
    var id: String
    var title: String
    var detail: String
    var timestamp: Timestamp
    
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.title = data["title"] as! String
        self.detail = data["detail"] as! String
        self.timestamp = data["timestamp"] as! Timestamp
    }
}
