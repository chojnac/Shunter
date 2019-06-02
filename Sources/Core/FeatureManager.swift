//
//  FeatureManager.swift
//  FeatureManager
//
//  Created by Wojciech Chojnacki on 30/01/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

public final class FeatureManager {
    static var configuredShared: FeatureManager?
    var shakeNotificationObserver: Any?

    private var features: [Feature: Bool] = [:]
    private var overridingStorage: SettingsStorage
    public var allFeatures: [Feature] {
        return features.keys.sorted(by: { $0.identifier < $1.identifier })
    }

    public init(overridingStorage: SettingsStorage) {
        self.overridingStorage = overridingStorage
    }

    deinit {
        if let observer = shakeNotificationObserver {
            NotificationCenter.default.removeObserver(observer)
            shakeNotificationObserver = nil
        }
    }

    public func isEnabled(_ feature: Feature) -> Bool {
        if let value = overridingStorage.isEnabled(feature) { //saved value
            return value
        }
        return features[feature] ?? false //default value or false if feature not registered
    }

    public func register(feature: Feature, defaultValue: Bool = false) {
        features[feature] = defaultValue
    }

    public func override(feature: Feature, value: Bool?) {
        overridingStorage.setFeature(feature: feature, isEnabled: value)
    }

    public func isOverrided(_ feature: Feature) -> Bool {
        return overridingStorage.isEnabled(feature) != nil
    }

    subscript(feature: Feature) -> Bool {
        return isEnabled(feature)
    }
}

extension FeatureManager {

    public static func setup(configuration: Configuration = .defaultConfiguration(), features: [Feature: Bool] = [:]) {
        configuredShared = FeatureManager(overridingStorage: UserDefaultsSettingsStorage(key: configuration.userDefaultsKey))
        for (key, defaultValue) in features {
            configuredShared?.register(feature: key, defaultValue: defaultValue)
        }
        configuredShared?.setupShakeHandler(enable: configuration.showOverrideScreenOnShake)
    }

    public static var shared: FeatureManager {
        guard let shared = configuredShared else {
            fatalError("Shared instance not initialized, run FeatureManager.setup method.")
        }

        return shared
    }
}

extension NSNotification.Name {
    public static let FeatureManagerShakeNotification = NSNotification.Name(rawValue: "FeatureManagerShakeNotification")
}
