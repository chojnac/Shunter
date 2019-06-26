//
//  UserDefaultsSettingsStorageTests.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 02/06/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

@testable import Shunter
import XCTest

class UserDefaultsSettingsStorageTests: XCTestCase {
    let userDefaultsKey = "shunter_unit_tests"
    let feature = Feature("unit_tests_feature")
    var storage: UserDefaultsSettingsStorage!

    override func setUp() {
        storage = UserDefaultsSettingsStorage(key: userDefaultsKey)
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }

    func test_set() {
        storage.setFeature(feature: feature, isEnabled: false)

        XCTAssertNotNil(storage.isEnabled(feature))
    }

    func test_set_userdefaults_has_key() {
        storage.setFeature(feature: feature, isEnabled: false)

        XCTAssertNotNil(storage.isEnabled(feature))
        if let values = UserDefaults.standard.object(forKey: userDefaultsKey) as? [String: Bool] {
            XCTAssertNotNil(values[feature.identifier])
        }
    }

    func test_delete() {
        storage.setFeature(feature: feature, isEnabled: false)
        storage.setFeature(feature: feature, isEnabled: nil)

        XCTAssertNil(storage.isEnabled(feature))
    }

    func test_isEnabled() {
        storage.setFeature(feature: feature, isEnabled: true)

        XCTAssertNotNil(storage.isEnabled(feature))
        if let result = storage.isEnabled(feature) {
            XCTAssertTrue(result)
        }
    }

    static var allTests = [
        ("test_set", test_set),
        ("test_set_userdefaults_has_key", test_set_userdefaults_has_key),
        ("test_delete", test_delete),
        ("test_isEnabled", test_isEnabled),
    ]
}
