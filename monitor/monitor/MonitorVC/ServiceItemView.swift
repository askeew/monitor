//
//  ServiceItemView.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-13.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import Domain

class ServiceItemView {

    public let id: String
    public let name: String
    public let url: URL
    var isOK: Bool?

    init(id: String,
         name: String,
         url: URL,
         isOK: Bool? = false) {
        self.id = id
        self.name = name
        self.url = url
        self.isOK = isOK
    }
}
