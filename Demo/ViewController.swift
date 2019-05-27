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
    
    @IBOutlet var featureLabel: UILabel!
    private var featureManager: FeatureManager! //because this is a root view controller it is created before AppDelegate complete initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureManager = FeatureManager.shared
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if featureManager.isEnabled(.testFeature) {
            featureLabel.text = "Test feature enabled"
            featureLabel.isHidden = false
        } else if featureManager.isEnabled(.feature01Feature) {
            featureLabel.text = "Feature 01 enabled"
            featureLabel.isHidden = false
        } else {
            featureLabel.isHidden = true
        }
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
