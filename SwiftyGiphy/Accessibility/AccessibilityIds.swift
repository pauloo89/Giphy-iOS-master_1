//
//  AccessibilityIds.swift
//  SwiftyGiphy
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

public enum AccessibilityIds {

    // MARK: Common

    private static let titleId = "Title"
    private static let viewId = "View"
    private static let buttonId = "Button"
    private static let textFieldId = "TextField"
    private static let cellId = "Cell"
    private static let switchUIElementId = "Switch"

    // MARK: - MainScreen

    enum MainScreen {

        static let title = "MainScreen" + titleId
        static let searchBar = "MainScreenSearchBar"

        enum ResultsTableView {
            static let resultsTableView = "Results" + viewId

            enum Cell {
                static let cell = resultsTableView + cellId
                static let userName = cell + "UserName"
                static let avatar = cell + "Avatar"
                static let gif = cell + "Gif"
            }

        }

        enum NoResultsView {
            static let noResultsView = "NoResults" + viewId
            static let textMessage = "TextMessage"
        }

        enum ErrorView {
            static let errorView = "Error" + viewId
        }

    }
}
