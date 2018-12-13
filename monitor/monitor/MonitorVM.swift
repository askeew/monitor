//
//  MonitorVM.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-12.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import RestAPI
import Domain

final class MonitorVM {

    private let repo: CRUD
    var items = [ServiceItem]()

    init(repo: CRUD = UserDefaultsRepo()) {
        self.repo = repo
    }

    public func fetchData(onSuccess: (() -> Void)? = nil) {
        items = repo.getAll()
        onSuccess?()
    }

    public func add(name: String, url: URL) {
        _ = repo.add(name: name, url: url)
        fetchData()
    }

    public func delete(id: Identifier<ServiceItem>) {
        repo.delete(id: id)
        fetchData()
    }
}
