//
//  RestAPITests.swift
//  RestAPITests
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import XCTest
@testable import RestAPI

class RepoTests: XCTestCase {

    override func setUp() {
        clear(InMemoryRepo())
        clear(UserDefaultsRepo())
    }

    func testInMemoryGetAll() {
        verifyGetAll(InMemoryRepo())
    }

    func testUserDefaultsGetAll() {
        verifyGetAll(UserDefaultsRepo())
    }

    func testInMemoryAdd() {
        verifyAdd(InMemoryRepo())
    }

    func testUserDefaultsAdd() {
        verifyAdd(UserDefaultsRepo())
    }

    func testInMemoryDelete() {
        verifyDelete(InMemoryRepo())
    }

    func testUserDefaultsDelete() {
        verifyDelete(UserDefaultsRepo())
    }

    private func verifyGetAll(_ repo: CRUD) {
        XCTAssertEqual(repo.getAll().count, 0)
    }

    private func verifyDelete(_ repo: CRUD) {
        let item = repo.add(name: "name", url: URL(fileURLWithPath: "name"))
        _ = repo.add(name: "name", url: URL(fileURLWithPath: "name"))
        XCTAssertEqual(repo.getAll().count, 2)
        repo.delete(id: item.id)
        XCTAssertEqual(repo.getAll().count, 1)
    }

    private func verifyAdd(_ repo: CRUD) {
        XCTAssertEqual(repo.getAll().count, 0)
        _ = repo.add(name: "name", url: URL(fileURLWithPath: "name"))
        XCTAssertEqual(repo.getAll().count, 1)
    }

    private func clear(_ repo: CRUD) {
        repo.getAll().forEach { repo.delete(id: $0.id) }
    }
}
