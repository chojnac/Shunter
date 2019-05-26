//
//  SettingsStorage.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 12/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

public protocol SettingsStorage {
    func isEnabled(_ feature: Feature) -> Bool?
    
    func setFeature(feature: Feature, isEnabled: Bool?)
}
