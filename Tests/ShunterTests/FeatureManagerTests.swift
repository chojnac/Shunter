//
//  FeatureManagerTests.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 02/06/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

@testable import Shunter
import XCTest

class FeatureManagerTests: XCTestCase {
    let feature = Feature("unit_tests_feature")
    var manager: FeatureManager!
    var overridingStorage: InMemorySettingsStorage!

    override func setUp() {
        overridingStorage = InMemorySettingsStorage()
        manager = FeatureManager(overridingStorage: overridingStorage)
    }

    override func tearDown() {
        FeatureManager.configuredShared = nil
    }

    func test_isEnabled_true_when_feature_exist() {
        manager.register(feature: feature, defaultValue: true)

        XCTAssertTrue(manager.isEnabled(feature))
    }

    func test_isEnabled_false_when_feature_not_avaliable() {
        XCTAssertTrue(manager.allFeatures.isEmpty)
        XCTAssertFalse(manager.isEnabled(feature))
    }

    func test_register_manager_has_feature() {
        manager.register(feature: feature, defaultValue: true)

        let result = manager.allFeatures.first
        XCTAssertNotNil(result)
        if let value = result {
            XCTAssertEqual(value, feature)
        }
    }

    func test_override_overrided_feature_in_overridingStorage() {
        manager.register(feature: feature, defaultValue: false)
        manager.override(feature: feature, value: true)

        XCTAssertNotNil(overridingStorage.isEnabled(feature))
    }

    func test_isOverrided_change_result_value() {
        manager.register(feature: feature, defaultValue: false)
        XCTAssertFalse(manager.isEnabled(feature))
        XCTAssertFalse(manager.isOverrided(feature))

        manager.override(feature: feature, value: true)

        XCTAssertTrue(manager.isEnabled(feature))
        XCTAssertTrue(manager.isOverrided(feature))
    }

    func test_subscript() {
        manager.register(feature: feature, defaultValue: true)
        XCTAssertTrue(manager[feature])
    }

    func test_singleton_setup() {
        FeatureManager.setup(features: [feature: true])

        XCTAssertTrue(FeatureManager.shared[feature])
    }

    static var allTests = [
        ("test_isEnabled_true_when_feature_exist", test_isEnabled_true_when_feature_exist),
        ("test_isEnabled_false_when_feature_not_avaliable", test_isEnabled_false_when_feature_not_avaliable),
        ("test_register_manager_has_feature", test_register_manager_has_feature),
        ("test_override_overrided_feature_in_overridingStorage", test_override_overrided_feature_in_overridingStorage),
        ("test_isOverrided_change_result_value", test_isOverrided_change_result_value),
        ("test_subscript", test_subscript),
        ("test_singleton_setup", test_singleton_setup),
    ]
}
