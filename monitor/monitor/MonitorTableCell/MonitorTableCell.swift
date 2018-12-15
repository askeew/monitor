//
//  MonitorTableCell.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-13.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import UIKit

class MonitorTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var url: UILabel!
    private var onSelect: (() -> Void)?

    public func newModel(model: MonitorTableCellVM) {
        name.attributedText = model.name
        statusIcon.image = model.icon
        url.attributedText = model.url
        url.isHidden = true
        onSelect = model.onSelect
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            onSelect?()
        }
    }
}
