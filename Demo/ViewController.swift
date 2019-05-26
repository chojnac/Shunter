//
//  ViewController.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 30/01/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import UIKit
import Shunter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionShowOverrideScreen(_ sender: Any) {
        let viewController = FeaturesOverrideViewController(featureManager: FeatureManager.shared)
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissOverrideScreen))
        present(navigationController, animated: true, completion: nil)
    }

    @objc func dismissOverrideScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
