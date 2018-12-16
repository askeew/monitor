//
//  AppTests.swift
//  AppTests
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import XCTest
@testable import monitor
@testable import Domain
@testable import RestAPI

class MonitorVMTests: XCTestCase {

    func testGivenDataExistsInRepo_fetchDataDeliversIt() {
        let repo = InMemoryRepo()
        _ = repo.add(name: "item1", url: URL(fileURLWithPath: "url1"))

        let vm = MonitorVM(repo: repo)
        XCTAssertEqual(vm.services.count, 0)
        vm.fetchData()
        XCTAssertEqual(vm.services.count, 1)
        XCTAssertEqual(vm.services[0].name, "item1")
        XCTAssertFalse(vm.services[0].isOK)
    }

    func testGivenDataExistsInRepo_checkServices_addsTimestampAndStatusToData() {
        let repo = InMemoryRepo()
        _ = repo.add(name: "item1", url: URL(fileURLWithPath: "url1"))

        let vm = MonitorVM(repo: repo)
        vm.fetchData()
        vm.checkServices()
        XCTAssertEqual(vm.services.count, 1)
        XCTAssertEqual(vm.services[0].name, "item1")
        XCTAssertEqual(vm.services[0].isOK, false)
    }


    func testGivenNoDataExistsInRepo_add_itemExists() {
        let vm = MonitorVM(repo: InMemoryRepo())
        XCTAssertEqual(vm.services.count, 0)
        vm.add(name: "item1", url: URL(fileURLWithPath: "url1"))

        XCTAssertEqual(vm.services.count, 1)
        XCTAssertEqual(vm.services[0].name, "item1")
    }

    func testGivenDataExistsInRepo_delete_itemIsDeleted() {
        let repo = InMemoryRepo()
        let item = repo.add(name: "item1", url: URL(fileURLWithPath: "url1"))

        let vm = MonitorVM(repo: repo)
        vm.fetchData()
        XCTAssertEqual(vm.services.count, 1)
        vm.delete(id: item.id.description)
        XCTAssertEqual(vm.services.count, 0)
    }
}
