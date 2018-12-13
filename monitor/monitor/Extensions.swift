//
//  Extensions.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-13.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func toAttributed(font: UIFont = .systemFont(ofSize: UIFont.systemFontSize),
                      color: UIColor = .black) -> NSAttributedString{

        let attributes = [NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font: font]
        return NSAttributedString(string: self, attributes: attributes)
    }
}


extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
