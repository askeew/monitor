//
//  ServiceItem.swift
//  Domain
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation

public class ServiceItem: Codable {

    public let id: Identifier<ServiceItem>
    public let name: String
    public let url: URL

    public init(id: Identifier<ServiceItem>,
                name: String,
                url: URL) {
        self.id = id
        self.name = name
        self.url = url
    }
}
