@testable import ShunterTests
import XCTest

XCTMain([
    testCase(FeatureManagerTests.allTests),
    testCase(InMemorySettingsStorageTests.allTests),
    testCase(UserDefaultsSettingsStorageTests.allTests),
])
