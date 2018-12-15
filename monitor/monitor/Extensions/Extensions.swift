//
//  Extensions.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-13.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
import UIKit
import Domain

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

extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.timeZone = TimeZone(abbreviation: "CET")
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}

// Concatenate attributed strings
func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}
