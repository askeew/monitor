//
//  MonitorTableCellVM.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-13.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation

import RestAPI
import Domain

struct MonitorTableCellVM {

    private let item: ServiceItemView

    init(item: ServiceItemView) {
        self.item = item
    }

    var name: NSAttributedString {
        return item.name.toAttributed(font: UIFont.systemFont(ofSize: 16), color: .black)
    }

    var url: NSAttributedString {
        return item.url.absoluteString.toAttributed()
    }

    var icon: UIImage? {
        switch isOK {
        case true: return UIImage(named: "up")
        case false: return UIImage(named: "down")
        }
    }

    var isOK: Bool {
        return item.isOK
    }
}


