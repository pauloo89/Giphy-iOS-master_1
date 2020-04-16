//
//  BasePageObject.swift
//  SwiftyGiphyUITests
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

import XCTest

class BasePageObject {
    
    let pageObjectsFactory: PageObjectsFactory
    let application: XCUIApplication
    
    required init(pageObjectsFactory: PageObjectsFactory, application: XCUIApplication) {
        self.pageObjectsFactory = pageObjectsFactory
        self.application = application
    }
    
    func clearSomeTextFieldWithoutClearButton(_ someXCUIElement: XCUIElement) {
        while !someXCUIElement.stringValue().isEmpty {
            someXCUIElement.doubleTap()
            someXCUIElement.typeText("\u{8}")
        }
    }
    
    func clearSomeTextFieldWithClearButton(_ someXCUIElement: XCUIElement) {
        someXCUIElement.buttons.firstMatch.tap()
    }
    
    func pasteSomeTextInTextField() {
        let menuItems = application.menus.firstMatch.menuItems
        let buttonNumber = menuItems.count - 1
        menuItems.element(boundBy: buttonNumber).tap()
    }
    
    func waitAndCheckForExistence(_ element: XCUIElement, timeout: TimeInterval = 5) {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssert(result == .completed, "Failed to find \(element) after \(timeout) seconds.")
    }
    
    func waitAndCheckForElementIsAbsent(_ element: XCUIElement, timeout: TimeInterval = 5) {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssert(result == .completed, "\(element) not absent after \(timeout) seconds.")
    }
    
    func waitAndCheckElementIsVisible(_ element: XCUIElement, timeout: TimeInterval = 5) {
        let predicate = NSPredicate(format: "hittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssert(result == .completed, "Failed to find \(element) after \(timeout) seconds.")
    }
    
}
