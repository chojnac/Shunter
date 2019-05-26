//
//  Configuration.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 19/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Foundation

public struct Configuration {
    public var userDefaultsKey: String
    public var showOverrideScreenOnShake: Bool

    public static func defaultConfiguration(showOverrideScreenOnShake: Bool = true) -> Configuration {
        return Configuration(userDefaultsKey: "featureManager", showOverrideScreenOnShake: showOverrideScreenOnShake)
    }
}
