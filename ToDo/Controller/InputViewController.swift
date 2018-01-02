//
//  InputViewController.swift
//  ToDo
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var dateTextField: UITextField!

  @IBOutlet var descriptionTextField: UITextField!
  @IBOutlet var saveButton: UIButton!


  var itemManager: ItemManager?
  
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  @IBAction func save() {
    guard let titleString = titleTextField.text,
      titleString.characters.count > 0 else { return }
    let date: Date?
    if let dateText = self.dateTextField.text,
      dateText.characters.count > 0 {
      date = dateFormatter.date(from: dateText)
    } else {
      date = nil
    }
    let descriptionString = descriptionTextField.text

      let item = ToDoItem(
        title: titleString,
        itemDescription: descriptionString,
        timestamp: date?.timeIntervalSince1970)
      
      self.itemManager?.add(item)
      dismiss(animated: true)
  }
}
