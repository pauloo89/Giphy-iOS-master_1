//
//  MainScreenTestSuite.swift
//  SwiftyGiphyUITests
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

import XCTest

class MainScreenTestSuite: BaseTestCase {

    func testSearchAndNoresultsView() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellsGif()
            .checkSearchBarText(someText: "Search GIPHY")
            .searchSomething(someText: " ")
            .waitNoResultsView()
            .checkNoResultsMessage()
            .checkSearchBarText(someText: " ")
            .pasteSomeTextInFocusedSearchBar(someText: "1")
            .checkSearchBarText(someText: " 1")
            .checkNoResultsMessageAbsent()
            .checkCellsWithGifCount(expectedCount: 10)
            .checkSearchClearButton()
    }
    
    func testSearchPagination() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellsGif()
            .searchSomething(someText: "time")
            .closeKeyboard()
            .checkCellsWithGifCount(expectedCount: 10)
            .checkPaginationWithSwipe(pageCount: 3)
    }

    func testMainScreenPagination() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellsGif()
            .checkPaginationWithSwipe(pageCount: 5)
        }
    
    func testSafePositionAfterReopen() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellsGif()
            .checkPaginationWithSwipe(pageCount: 2)
            .restartAppAndCheckState()
            .checkPaginationWithSwipe(pageCount: 2, continuePagination: true)
        }
    
}
