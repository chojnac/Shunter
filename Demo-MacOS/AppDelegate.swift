//
//  AppDelegate.swift
//  Demo-MacOS
//
//  Created by Wojciech Chojnacki on 26/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Cocoa
import Shunter

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        FeatureManager.setup(
            configuration: .defaultConfiguration(showOverrideScreenOnShake: false),
            features: [
                .testFeature: false,
                .feature01Feature: true
            ])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
