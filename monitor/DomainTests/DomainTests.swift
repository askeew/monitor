//
//  DomainTests.swift
//  DomainTests
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import XCTest
@testable import Domain

class DomainTests: XCTestCase {

    func testServiceItem() {
        let item = ServiceItem(id: "id", name: "name", url: URL(fileURLWithPath: "url"))
        XCTAssertNotNil(item)
        XCTAssertEqual(item.id.description, "id")
        XCTAssertEqual(item.name, "name")
        XCTAssertEqual(item.url.absoluteString, "file:///url")
    }
}
