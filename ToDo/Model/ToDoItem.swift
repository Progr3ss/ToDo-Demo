//
//  ToDoItem.swift
//  ToDo
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
  let title: String
  let itemDescription: String?
  let timestamp: Double?
  
  private let titleKey = "titleKey"
  private let itemDescriptionKey = "itemDescriptionKey"
  private let timestampKey = "timestampKey"
  
  var plistDict: [String:Any] {
    var dict = [String:Any]()
    dict[titleKey] = title
    if let itemDescription = itemDescription {
      dict[itemDescriptionKey] = itemDescription
    }
    if let timestamp = timestamp {
      dict[timestampKey] = timestamp
    }

    return dict
  }
  
  init(title: String,
       itemDescription: String? = nil,
       timestamp: Double? = nil) {
    
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timestamp

  }
  
  init?(dict: [String:Any]) {
    guard let title = dict[titleKey] as? String else
    { return nil }
    
    self.title = title
    
    self.itemDescription = dict[itemDescriptionKey] as? String
    self.timestamp = dict[timestampKey] as? Double

  }
  
  public static func ==(lhs: ToDoItem,
                        rhs: ToDoItem) -> Bool {
    

    if lhs.timestamp != rhs.timestamp {
      return false
    }
    
    if lhs.itemDescription != rhs.itemDescription {
      return false
    }
    
    if lhs.title != rhs.title { 
      return false 
    } 
    
    return true
  }
}

