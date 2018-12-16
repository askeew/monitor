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

    public func newModel(model: MonitorTableCellVM) {
        selectionStyle = .none
        name.attributedText = model.name
        statusIcon.image = model.icon
        url.attributedText = model.url
        url.isHidden = true
        let tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler(gesture:)))
        tapRecognizer.minimumPressDuration = 0.1
        addGestureRecognizer(tapRecognizer)
    }

    @objc func tapHandler(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            url.isHidden = false
        } else if gesture.state == .ended {
            url.isHidden = true
        }
    }
}
