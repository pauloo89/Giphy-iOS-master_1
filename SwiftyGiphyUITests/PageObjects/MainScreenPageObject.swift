//
//  MainScreenPageObject.swift
//  SwiftyGiphyUITests
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

import XCTest

final class MainScreenPageObject: BasePageObject {
    
    private let id = AccessibilityIds.MainScreen.self
    
    // MARK: - XCUIElements
    
    
    private lazy var searchBar = application.otherElements[id.searchBar].firstMatch
    private lazy var searchTextField = searchBar.searchFields.firstMatch
    private lazy var resultsTableView = application.tables[id.ResultsTableView.resultsTableView].firstMatch
    private lazy var gifCells = resultsTableView.cells
    private lazy var noResultsView = application.otherElements[id.NoResultsView.noResultsView].firstMatch
    private lazy var noResultViewMessage = noResultsView.staticTexts[id.NoResultsView.textMessage].firstMatch
    
    // MARK: - Helpers
    
    func waitLoadCellsGif() -> Self {
        waitAndCheckForExistence(gifCells.element(boundBy: 0), timeout: 20)
        return self
    }
    
    func checkCellsWithGifCount(expectedCount: Int) -> Self {
        XCTAssertEqual(gifCells.count, expectedCount)
        return self
    }
    
    func checkSearchClearButton() {
        let userName = gifCells.element(boundBy: 0).staticTexts[id.ResultsTableView.Cell.userName].label
        clearSomeTextFieldWithClearButton(searchTextField)
        sleep(1)
        XCTAssertNotEqual(gifCells.element(boundBy: 0).staticTexts[id.ResultsTableView.Cell.userName].label, userName)
    }
    
    func checkSearchBarText(someText: String) -> Self {
        XCTAssertEqual(searchTextField.stringValue(), someText)
        return self
    }
    
    func pasteSomeTextInFocusedSearchBar(someText: String) -> Self {
        UIPasteboard.general.string = someText
        searchTextField.tap()
        pasteSomeTextInTextField()
        return self
    }
    
    func searchSomething(someText: String) -> Self {
        searchTextField.tap()
        searchTextField.typeText(someText)
        return self
    }
    
    func closeKeyboard() -> Self {
        application.keyboards.buttons["done"].firstMatch.tap()
        return self
    }
    
    func waitNoResultsView() -> Self {
        waitAndCheckForExistence(noResultsView)
        return self
    }
    
    func checkNoResultsMessage() -> Self {
        waitAndCheckElementIsVisible(noResultViewMessage)
        XCTAssertEqual(noResultViewMessage.label, "No Results")
        return self
    }
    
    func checkNoResultsMessageAbsent() -> Self {
        waitAndCheckForElementIsAbsent(noResultViewMessage)
        return self
    }
    
    func getSwipedCellsCount(swipedCellsCount: Int = 0) -> Int {
        var localSwipedCellsCount: Int = swipedCellsCount

        for i in localSwipedCellsCount ... gifCells.count - 1 {
            if gifCells.element(boundBy: i).frame.maxY < searchTextField.frame.maxY + 20 {
                localSwipedCellsCount += 1
            }
        }
        return localSwipedCellsCount
    }
    
    @discardableResult
    func checkPaginationWithSwipe(pageCount: Int, continuePagination: Bool = false) -> Self {
        var expectedCellCount = pageCount * 10
        var swipedCellsCount = 0
        var swipeCount = 0
        
        if continuePagination == true {
            swipedCellsCount = getSwipedCellsCount()
            swipeCount = swipedCellsCount - 3
            expectedCellCount = expectedCellCount + swipedCellsCount
            
        }
        
        while swipedCellsCount <= expectedCellCount - 1 {
            
            if gifCells.element(boundBy: swipedCellsCount + 1).isHittable {
                let fromSwipe = gifCells.element(boundBy: swipedCellsCount + 1).staticTexts.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.00))
                let toSwipe = gifCells.element(boundBy: swipedCellsCount).staticTexts.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.5))
                fromSwipe.press(forDuration: 0, thenDragTo: toSwipe)
            } else {
                gifCells.element(boundBy: swipedCellsCount + 1).tap()
            }
            
            swipeCount += 1
            swipedCellsCount = getSwipedCellsCount(swipedCellsCount: swipedCellsCount)
        }
        
        if gifCells.count < swipeCount {
            XCTFail("После \(swipeCount) скроллов след страница не подгрузилась")
            
        }
        
        return self
    }
    
    func restartAppAndCheckState() -> Self {
        let cellNumber = gifCells.count - 1
        let selectedCell = gifCells.element(boundBy: cellNumber)
        selectedCell.tap()
        let expectedUserName = selectedCell.staticTexts.firstMatch.label
        let expectedFrame = selectedCell.frame
        
        XCUIApplication.preferences.launch()
        application.activate()
        XCTAssertEqual(expectedFrame, gifCells.element(boundBy: cellNumber).frame)
        XCTAssertEqual(expectedUserName, gifCells.element(boundBy: cellNumber).staticTexts.firstMatch.label)
        return self
    }
    
}
