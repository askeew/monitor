//
//  ServicesRepo.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import Domain

public protocol CRUD {
    func getAll() -> [ServiceItem]
    func add(name: String, url: URL) -> ServiceItem
    func delete(id: Identifier<ServiceItem>)
}

public class UserDefaultsRepo: CRUD {

    private let key = "serviceItems"

    public init() {
    }

    public func getAll() -> [ServiceItem] {
        return readValue(key: key) ?? [ServiceItem]()
    }

    public func add(name: String, url: URL) -> ServiceItem {
        let item = ServiceItem(id: Identifier<ServiceItem>(UUID().uuidString),
                               name: name,
                               url: url)
        var persistedData = getAll()
        persistedData.append(item)
        persistValue(value: persistedData, forKey: key)
        return item
    }

    public func delete(id: Identifier<ServiceItem>) {
        var persistedData = getAll()
        persistedData.removeAll { $0.id == id }
        persistValue(value: persistedData, forKey: key)
    }

    private func persistValue<T: Codable>(value: T?, forKey key: String) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }

    private func readValue<T: Codable>(key: String) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
}

public class InMemoryRepo: CRUD {

    var data = [ServiceItem]()

    public func getAll() -> [ServiceItem] {
        return data
    }

    public func add(name: String, url: URL) -> ServiceItem{
        let id = Identifier<ServiceItem>(UUID().uuidString)
        let newItem = ServiceItem(id: id,
                                  name: name,
                                  url: url)
        data.append(newItem)
        return newItem
    }

    public func delete(id: Identifier<ServiceItem>) {
        data.removeAll { $0.id == id }
    }
}
