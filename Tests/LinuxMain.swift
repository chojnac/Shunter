import XCTest
@testable import ShunterTests

XCTMain([
    testCase(FeatureManagerTests.allTests),
    testCase(InMemorySettingsStorageTests.allTests),
    testCase(UserDefaultsSettingsStorageTests.allTests),
])
