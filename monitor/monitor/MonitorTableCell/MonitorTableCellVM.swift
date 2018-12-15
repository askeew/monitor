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
    let onSelect: (() -> Void)?

    init(item: ServiceItemView, onSelect: (() -> Void)?) {
        self.item = item
        self.onSelect = onSelect
    }

    var name: NSAttributedString {
        return item.serviceItem.name.toAttributed(font: UIFont.systemFont(ofSize: 16), color: .black)
    }

    var url: NSAttributedString {
        return item.serviceItem.url.absoluteString.toAttributed()
    }

    var timeChecked: NSAttributedString {
        let postFix = "Last checked: ".toAttributed()
        if let time = item.time {
            return postFix + time.localizedDescription(dateStyle: .none, timeStyle: .medium).toAttributed()
        }
        return "".toAttributed()
    }

    var icon: UIImage? {
        switch item.isOK {
        case true: return UIImage(named: "up")
        case false: return UIImage(named: "down")
        default: return nil
        }
    }
}


