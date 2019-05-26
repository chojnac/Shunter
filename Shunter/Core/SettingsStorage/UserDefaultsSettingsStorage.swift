//
//  UserDefaultsSettingsStorage.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 15/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

public final class UserDefaultsSettingsStorage: SettingsStorage {
    private let key: String
    private let userDefaults: UserDefaults

    init(key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.userDefaults = userDefaults
    }

    private func buildKey(for feature: Feature) -> String {
        return "\(self.key).\(feature.identifier)"
    }

    private func values() -> [String: Bool] {
        if let values = userDefaults.dictionary(forKey: key) as? [String: Bool] {
            return values
        }
        return [:]
    }

    public func isEnabled(_ feature: Feature) -> Bool? {
        let values = self.values()
        guard let value = values[feature.identifier] else {
            return nil
        }
        return value
    }

    public func setFeature(feature: Feature, isEnabled: Bool?) {
        var values = self.values()

        if let value = isEnabled {
            values[feature.identifier] = value
        } else {
            values.removeValue(forKey: feature.identifier)
        }
        userDefaults.set(values, forKey: key)
        userDefaults.synchronize()
    }

}
