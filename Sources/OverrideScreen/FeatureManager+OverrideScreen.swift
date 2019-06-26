//
//  FeatureManager+OverrideScreen.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 19/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
extension FeatureManager {
    #if canImport(UIKit)
        public func presentOverrideScreen() {
            guard let window = UIApplication.shared.delegate?.window ?? nil else {
                return
            }

            var vc = window.rootViewController
            while let presentingViewController = vc?.presentingViewController {
                vc = presentingViewController
            }

            guard let topViewController = vc else {
                return
            }

            if let navigationController = topViewController as? UINavigationController,
                navigationController.topViewController is FeaturesOverrideViewController {
                return
            }

            let viewController = RootFeatureOverrideController(featureManager: self)
            topViewController.present(viewController, animated: true, completion: nil)
        }
    #endif

    public func setupShakeHandler(enable: Bool) {
        guard enable else { return }
        #if canImport(UIKit)
            shakeNotificationObserver = NotificationCenter.default.addObserver(forName: .FeatureManagerShakeNotification,
                                                                               object: nil,
                                                                               queue: OperationQueue.main) { [weak self] _ in
                self?.presentOverrideScreen()
            }
        #endif
    }
}

#if canImport(UIKit)
    private final class RootFeatureOverrideController: UINavigationController {
        convenience init(featureManager: FeatureManager) {
            let viewController = FeaturesOverrideViewController(featureManager: featureManager)
            self.init(rootViewController: viewController)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("FeatureOverride.Button.Close", bundle: Bundle(for: type(of: self)), comment: ""), style: .done, target: self, action: #selector(dismissOverrideScreen))
        }

        @objc func dismissOverrideScreen(_: Any) {
            dismiss(animated: true, completion: nil)
        }
    }
#endif
