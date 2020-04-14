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
    private lazy var gifCells = resultsTableView.descendants(matching: .cell).matching(identifier: id.ResultsTableView.Cell.cell)
    private lazy var noResultsView = application.otherElements[id.NoResultsView.noResultsView].firstMatch
    private lazy var noResultViewMessage = noResultsView.staticTexts[id.NoResultsView.textMessage].firstMatch

    // MARK: - Helpers

    func waitLoadCellsGif() -> Self {
        waitAndCheckForExistence(gifCells.element(boundBy: 0))
        return self
    }

    func checkCellsWithGifCount(expectedCount: Int) -> Self {
        XCTAssertEqual(gifCells.count, expectedCount)
        return self
    }

    func checkSearchBarText(someText: String) -> Self {
        XCTAssertEqual(searchTextField.stringValue(), someText)
        return self
    }

    func pasteSomeTextInSearchBar(someText: String) -> Self {
        UIPasteboard.general.string = someText
        searchTextField.tap()
        sleep(1)
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

    func checkNoResultsMessageAbsent() {
        waitAndCheckForElementIsAbsent(noResultViewMessage)
    }

    func checkPaginationWithSwipe(pageCount: Int) {
        let expectedCellCount = pageCount * 10
        var scrollsCount = 0

        for i in 1 ..< expectedCellCount - 3 {
            let secondCellFrame = gifCells.element(boundBy: i).coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.01))
            let firstCellFrame = gifCells.element(boundBy: i - 1).coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.5))

            secondCellFrame.press(forDuration: 0, thenDragTo: firstCellFrame)

            if gifCells.element(boundBy: i - 1).frame.minY < 0 {
                scrollsCount = i }

            if scrollsCount >= expectedCellCount - 11 {
                XCTFail("После \(scrollsCount) скроллов след страница не подгрузилась")
            }

            if gifCells.count == expectedCellCount {
                break
            }

        }
    }

    func checkPaginationWithTap(pageCount: Int) {
        var cellCount = pageCount + 1
        cellCount = cellCount * 10

        for _ in 0 ..< pageCount {
            gifCells.element(boundBy: gifCells.count - 2 ).tap()
            print(application.debugDescription)
            waitAndCheckForExistence(gifCells.element(boundBy: gifCells.count - 2).images[id.ResultsTableView.Cell.avatar].firstMatch, timeout: 10)
            waitAndCheckForExistence(gifCells.element(boundBy: gifCells.count - 2).images[id.ResultsTableView.Cell.gif].firstMatch, timeout: 10)
        }

        print(application.cells.debugDescription)
        XCTAssertEqual(gifCells.count, cellCount)

    }


}
