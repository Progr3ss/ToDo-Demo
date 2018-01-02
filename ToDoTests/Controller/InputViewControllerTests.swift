//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class InputViewControllerTests: XCTestCase {
  
  var sut: InputViewController!

  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: "Main",
                                  bundle: nil)
    sut = storyboard
      .instantiateViewController(
        withIdentifier: "InputViewController")
      as! InputViewController
    
    
    sut.loadViewIfNeeded()
    
  }
  
  override func tearDown() {
    sut.itemManager?.removeAll()
    
    super.tearDown()
  }
  
  func test_HasTitleTextField() {
    let titleTextFieldIsSubView =
      sut.titleTextField?.isDescendant(
        of: sut.view) ?? false
    XCTAssertTrue(titleTextFieldIsSubView)
  }

  func test_SaveButtonHasSaveAction() {
    let saveButton: UIButton = sut.saveButton
    
    
    guard let actions = saveButton.actions(
      forTarget: sut,
      forControlEvent: .touchUpInside) else {
        XCTFail(); return
    }
    
    
    XCTAssertTrue(actions.contains("save"))
  }

  
  func testSave_DismissesViewController() {
    let mockInputViewController = MockInputViewController()
    mockInputViewController.titleTextField = UITextField()
    mockInputViewController.dateTextField = UITextField()
    mockInputViewController.descriptionTextField = UITextField()
    mockInputViewController.titleTextField.text = "Test Title"
    
    mockInputViewController.save()
    
    XCTAssertTrue(mockInputViewController.dismissGotCalled)
  }
}

extension InputViewControllerTests {

  
  class MockInputViewController : InputViewController {
    
    var dismissGotCalled = false
    var completionHandler: (() -> Void)?
    
    override func dismiss(animated flag: Bool,
                          completion: (() -> Void)? = nil) {
      
      dismissGotCalled = true
      completionHandler?()
    }
  }
}
