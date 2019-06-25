//
//  DemoData.swift
//  Demo
//
//  Created by Wojciech Chojnacki on 25/06/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

struct Lyrics {
    let title: String
    let body: String
    
    static func song1() -> Lyrics {
        let title = "What a Wonderful World"
        let body = """
    I see trees of green, red roses too
    I see them bloom for me and you
    And I think to myself what a wonderful world
    """
        return .init(title: title, body: body)
    }
}
