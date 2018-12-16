//
//  XCUIApplication+Extension.swift
//  MonitorUITests
//
//  Created by Askia Linder on 2018-12-16.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication {
    var noOfServices: Int {
        return cells.count
    }

    var addServiceButton: XCUIElement {
        return buttons["Add"]
    }

    var serviceNameField: XCUIElement {
        return alerts["Add service"].collectionViews.textFields["Name"]
    }

    var serviceDomainNameField: XCUIElement {
        return alerts["Add service"].collectionViews.textFields["Domain name"]
    }

    func typeText(to field: XCUIElement, with text: String) {
        field.tap()
        field.typeText(text)
    }

    var addServiceOKButton: XCUIElement {
        return alerts["Add service"].buttons["OK"]
    }
}
