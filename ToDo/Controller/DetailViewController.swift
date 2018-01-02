//
//  DetailViewController.swift
//  ToDo
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//
import UIKit
import MapKit

class DetailViewController: UIViewController {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var mapView: MKMapView!

  var itemInfo: (ItemManager, Int)?
  
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let itemInfo = itemInfo else { return }
    let item = itemInfo.0.item(at: itemInfo.1)
    
    titleLabel.text = item.title
    descriptionLabel.text = item.itemDescription
    
    if let timestamp = item.timestamp {
      let date = Date(timeIntervalSince1970: timestamp)
      dateLabel.text = dateFormatter.string(from: date)
    }
    

  }
  
  func checkItem() {
    if let itemInfo = itemInfo {
      itemInfo.0.checkItem(at: itemInfo.1)
    }
  } 
}
