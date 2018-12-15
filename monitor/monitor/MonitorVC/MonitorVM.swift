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

protocol RefreshDelegate: class {
    func refresh()
}

final class MonitorVM {

    private let repo: CRUD
    weak var refreshDelegate: RefreshDelegate?
    var services = [ServiceItemView]()

    init(repo: CRUD = UserDefaultsRepo()) {
        self.repo = repo
    }

    public func fetchData() {
        services = [ServiceItemView]()
        services = repo.getAll().map { ServiceItemView(serviceItem: $0, isOK: nil, time: nil) }
    }

    public func add(name: String, url: URL) {
        _ = repo.add(name: name, url: url)
        fetchData()
    }

    public func delete(id: Identifier<ServiceItem>) {
        repo.delete(id: id)
        fetchData()
    }

    @objc public func checkServices() {
        //TODO loading
        let group = DispatchGroup()
        services.forEach { item in
            group.enter()
            let task = URLSession.shared.dataTask(with: item.serviceItem.url) { _, response, _ in
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 {
                    item.isOK = true
                } else {
                    item.isOK = false
                }
                item.time = Date()
                group.leave()
            }
            task.resume()
        }
        group.wait()
        refreshDelegate?.refresh()
    }
}
