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
            .waitLoadCellIsVisible()
            .checkScreenTitle()
            .checkSearchBarText(someText: "Search GIPHY")
            .searchSomething(someText: " ")
            .checkScreenTitle()
            .waitNoResultsView()
            .checkNoResultsMessage()
            .checkScreenTitle()
            .checkSearchBarText(someText: " ")
            .pasteSomeTextInFocusedSearchBar(someText: "1")
            .checkSearchBarText(someText: " 1")
            .checkNoResultsMessageAbsent()
            .checkScreenTitle()
            .checkCellsWithGifCount(expectedCount: 10)
            .checkSearchClearButton()
    }
    
    func testSearchPagination() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellIsVisible()
            .searchSomething(someText: "time")
            .closeKeyboard()
            .checkCellsWithGifCount(expectedCount: 10)
            .checkPaginationWithSwipe(pageCount: 3)
    }
    
    func testMainScreenPagination() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellIsVisible()
            .checkPaginationWithSwipe(pageCount: 5)
    }
    
    func testSafePositionAfterReopen() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellIsVisible()
            .checkPaginationWithSwipe(pageCount: 2)
            .checkScreenTitle()
            .restartAppAndCheckState()
            .checkPaginationWithSwipe(pageCount: 2, continuePagination: true)
    }
    
    func testCellsElement() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .checkCellsElements()
    }
    
    func testErrorScreen() {
        pageObjectsFactory
            .makeMainScreenPageObject()
            .waitLoadCellIsVisible()
            .checkSomethingWentWrongScreen()
            .checkScreenTitle()
    }
    
}
