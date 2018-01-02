//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class DetailViewControllerTests: XCTestCase {
  
  var sut: DetailViewController!
  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: "Main",
                                  bundle: nil)
    sut = storyboard
      .instantiateViewController(
        withIdentifier: "DetailViewController")
      as! DetailViewController
    sut.loadViewIfNeeded()
  }
  
  override func tearDown() {
    sut.itemInfo?.0.removeAll()
    
    super.tearDown()
  }
  
  func test_HasTitleLabel() {
    let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
    XCTAssertTrue(titleLabelIsSubView)
  }
  


}
