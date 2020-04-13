//
//  XCUIElement+Extension.swift
//  SwiftyGiphyUITests
//
//  Created by Pavel Naumenko on 13.04.2020.
//  Copyright © 2020 andrewlupul. All rights reserved.
//

import XCTest

extension XCUIElement {

    func stringValue(defaultValue: String = "") -> String {
        guard exists else {
            return defaultValue
        }

        return value as? String ?? defaultValue
    }

}

