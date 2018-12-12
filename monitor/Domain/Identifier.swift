//
//  Identifier.swift
//  Domain
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import Foundation
public struct Identifier<T>: Hashable {

    public let string: String

    public init(_ string: String) {
        self.string = string
    }
}

extension Identifier: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        string = value
    }
}

extension Identifier: CustomStringConvertible {
    public var description: String {
        return string
    }
}

extension Identifier: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        string = try container.decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}
