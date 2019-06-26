//
//  UIWindow+shake.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 19/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    extension UIWindow {
        open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            super.motionEnded(motion, with: event)
            if motion == .motionShake {
                NotificationCenter.default.post(name: NSNotification.Name.FeatureManagerShakeNotification, object: nil)
            }
        }
    }

#endif
