//
//  ItemCell.swift
//  ToDo
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  func configCell(with item: ToDoItem,
                  checked: Bool = false) {
    
    if checked {
      let attributedString = NSAttributedString(
        string: item.title,
        attributes: [NSAttributedStringKey.strikethroughStyle:
          NSUnderlineStyle.styleSingle.rawValue])
      
      
      titleLabel.attributedText = attributedString
      locationLabel.text = nil
      dateLabel.text = nil
    } else {
      
      titleLabel.text = item.title      
      if let timestamp = item.timestamp {
        let date = Date(timeIntervalSince1970: timestamp)
        
        
        dateLabel.text = dateFormatter.string(from: date)
      }
    }
  }
}
