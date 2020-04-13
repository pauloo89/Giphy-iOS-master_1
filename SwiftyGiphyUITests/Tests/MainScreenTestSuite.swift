//
//  MainScreenTestSuite.swift
//  SwiftyGiphyUITests
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

import XCTest

class MainScreenTestSuite: BaseTestCase {

    func testSearchResults() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .checkSearchBarText(someText: "Search GIPHY")
            .searchSomething(someText: " ")
            .waitNoResultsView()
            .checkNoResultsMessage()
            .checkSearchBarText(someText: " ")
            .closeKeyboard()
            .pasteSomeTextInSearchBar(someText: "1")
            .checkSearchBarText(someText: " 1")
            .closeKeyboard()
            .checkCellsWithGifCount(expectedCount: 10)
    }
    
}
