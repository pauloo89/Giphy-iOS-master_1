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
    private lazy var cells = resultsTableView.descendants(matching: .cell).matching(identifier: id.ResultsTableView.Cell.cell)
    private lazy var noResultsView = application.otherElements[id.NoResultsView.noResultsView].firstMatch
    private lazy var noResultViewMessage = noResultsView.staticTexts[id.NoResultsView.textMessage].firstMatch

    // MARK: - Helpers

    func checkCellsWithGifCount(expectedCount: Int) {
        XCTAssertEqual(cells.count, expectedCount)
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


}
