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
        app.typeText(to: app.serviceNameField, with: "sl correct")
        app.typeText(to: app.serviceDomainNameField, with: "sl.se")
        app.addServiceOKButton.tap()

        app.addServiceButton.tap()
        app.typeText(to: app.serviceNameField, with: "sl error")
        app.typeText(to: app.serviceDomainNameField, with: "sl.sl.se")
        app.addServiceOKButton.tap()

        let serviceUpPredicate = NSPredicate(format: "label ENDSWITH 'true'")
        let serviceUpLabel = app.cells.element(boundBy: 0).staticTexts.element(matching: serviceUpPredicate)
        XCTAssert(serviceUpLabel.exists)

        let serviceDownPredicate = NSPredicate(format: "label ENDSWITH 'false'")
        let serviceDownLabel = app.cells.element(boundBy: 1).staticTexts.element(matching: serviceDownPredicate)
        XCTAssert(serviceDownLabel.exists)

        XCTAssertEqual(app.noOfServices, 2)
        app.cells.element(boundBy: 0).swipeLeft()
        app.cells.element(boundBy: 0).buttons["Delete"].tap()
        XCTAssertEqual(app.noOfServices, 1)
    }

    func testPullToRefresh_willUpdateTime() {
         app.launch()

        guard let then = app.timeLabelToDate(app.checkedTimeLabel.label) else { return XCTFail() }

        let start = app.checkedTimeLabel.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = app.checkedTimeLabel.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 15))
        start.press(forDuration: 0, thenDragTo: finish)

        guard let now = app.timeLabelToDate(app.checkedTimeLabel.label) else { return XCTFail() }
        XCTAssertTrue(now > then)
    }
}
