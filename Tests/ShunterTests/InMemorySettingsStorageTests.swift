//
//  InMemorySettingsStorageTests.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 02/06/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

@testable import Shunter
import XCTest

class InMemorySettingsStorageTests: XCTestCase {
    let feature = Feature("unit_tests_feature")
    var storage: InMemorySettingsStorage!

    override func setUp() {
        storage = InMemorySettingsStorage()
    }

    func test_set() {
        storage.setFeature(feature: feature, isEnabled: false)

        XCTAssertNotNil(storage.isEnabled(feature))
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
        ("test_delete", test_delete),
        ("test_isEnabled", test_isEnabled),
    ]
}
