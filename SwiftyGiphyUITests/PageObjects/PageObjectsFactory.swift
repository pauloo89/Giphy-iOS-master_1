//
//  PageObjectsFactory.swift
//  SwiftyGiphyUITests
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

import XCTest

final class PageObjectsFactory {
    
    private let application: XCUIApplication
    
    init(application: XCUIApplication) {
        self.application = application
    }
    
    private func initializePageObject<PageObject: BasePageObject>(ofType type: PageObject.Type) -> PageObject {
        return type.init(pageObjectsFactory: self,
                         application: application)
    }
    
    // MARK: - PageObjects
    
    
}
