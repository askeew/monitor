//
//  MonitorUITests.swift
//  MonitorUITests
//
//  Created by Askia Linder on 2018-12-16.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import XCTest

class MonitorUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testRegression() {
        app.launch()
        XCTAssertEqual(app.noOfServices, 0)
        app.addServiceButton.tap()

        app.typeText(to: app.serviceNameField, with: "sl")
        app.typeText(to: app.serviceDomainNameField, with: "sl.se")
        app.addServiceOKButton.tap()

        XCTAssertEqual(app.noOfServices, 1)
        app.cells.element(boundBy: 0).swipeLeft()
        app.cells.element(boundBy: 0).buttons["Delete"].tap()
        XCTAssertEqual(app.noOfServices, 0)
    }
}
