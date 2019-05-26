//
//  Feature.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 30/01/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

public struct Feature: Hashable {
    public typealias Identifier = String
    public let identifier: Identifier
    public let comment: String?

    public init(_ identifier: Identifier, comment: String? = nil) {
        self.identifier = identifier
        self.comment = comment
    }
}
