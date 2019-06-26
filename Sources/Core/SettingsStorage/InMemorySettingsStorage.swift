//
//  InMemorySettingsStorage.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 12/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

public final class InMemorySettingsStorage: SettingsStorage {
    public func isEnabled(_ feature: Feature) -> Bool? {
        return values[feature.identifier]
    }

    public func setFeature(feature: Feature, isEnabled: Bool?) {
        guard let isEnabled = isEnabled else {
            values.removeValue(forKey: feature.identifier)
            return
        }
        values[feature.identifier] = isEnabled
    }

    private var values: [String: Bool] = [:]
}
