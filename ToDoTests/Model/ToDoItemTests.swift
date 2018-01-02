//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Martin Chibwe on 12/29/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_Init_WhenGivenTitle_SetsTitle() {
    let item = ToDoItem(title: "Foo")
    
    XCTAssertEqual(item.title, "Foo", "should set title")
  }
  
  func test_Init_WhenGivenDescription_SetsDescripiton() {
    
    let item = ToDoItem(title: "",
                        itemDescription: "Bar")
    
    XCTAssertEqual(item.itemDescription,
                   "Bar",
                   "should set itemDescription")
  }
  
  func test_Init_SetsTimestamp() {
    
    let item = ToDoItem(title: "",
                        timestamp: 0.0)
    
    XCTAssertEqual(item.timestamp, 0.0)
  }

  func test_EqualItems_AreEqual() {
    let first = ToDoItem(title: "Foo")
    let second = ToDoItem(title: "Foo")
    
    
    XCTAssertEqual(first, second)
  }
  

  func test_Items_WhenTimestampsDiffer_AreNotEqual() {
    
    
    let first = ToDoItem(title: "Foo",
                         timestamp: 1.0)
    let second = ToDoItem(title: "Foo",
                          timestamp: 0.0)
    
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenDescriptionsDiffer_AreNotEqual() {
    
    
    let first = ToDoItem(title: "Foo",
                         itemDescription: "Bar")
    let second = ToDoItem(title: "Foo",
                          itemDescription: "Baz")
    
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenTitlesDiffer_AreNotEqual() {
    
    
    let first = ToDoItem(title: "Foo")
    let second = ToDoItem(title: "Bar")
    
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_HasPlistDictionaryProperty() {
    let item = ToDoItem(title: "First")
    let dictionary = item.plistDict
    
    XCTAssertNotNil(dictionary)
    XCTAssertTrue(dictionary is [String:Any])
  }
  
  func test_CanBeCreatedFromPlistDictionary() {
    let item = ToDoItem(title: "Foo",
                        itemDescription: "Baz",
                        timestamp: 1.0)
    
    
    let dict = item.plistDict
    let recreatedItem = ToDoItem(dict: dict)
    
    XCTAssertEqual(item, recreatedItem)
  }
}
