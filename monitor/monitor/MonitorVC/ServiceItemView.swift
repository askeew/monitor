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
    let serviceItem: ServiceItem
    var isOK: Bool?
    var time: Date?

    init(serviceItem: ServiceItem,
                isOK: Bool? = false,
                time: Date? = nil) {
        self.serviceItem = serviceItem
        self.isOK = isOK
        self.time = time
    }
}
