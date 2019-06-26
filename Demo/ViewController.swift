//
//  ViewController.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 30/01/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

import Shunter
import UIKit

class ViewController: UIViewController {
    @IBOutlet var decoration1Labels: [UILabel]!

    @IBOutlet var decoration2Labels: [UILabel]!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    private var featureManager: FeatureManager! // because this is a root view controller it is created before AppDelegate complete initialization

    private var lyrics = Lyrics.song1()

    override func viewDidLoad() {
        super.viewDidLoad()
        featureManager = FeatureManager.shared

        decoration2Labels.forEach {
            $0.text = "🦄"
        }

        decoration1Labels.forEach {
            $0.text = "🌈"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if featureManager.isEnabled(.unicornsFeature) {
            decoration2Labels.forEach { $0.isHidden = false }
        } else {
            decoration2Labels.forEach { $0.isHidden = true }
        }

        if featureManager.isEnabled(.rainbowFeature) {
            decoration1Labels.forEach { $0.isHidden = false }
        } else {
            decoration1Labels.forEach { $0.isHidden = true }
        }
        populate()
    }

    private func populate() {
        titleLabel.text = lyrics.title
        bodyLabel.text = lyrics.body
    }

    @IBAction func actionShowOverrideScreen(_: Any) {
        let viewController = FeaturesOverrideViewController(featureManager: FeatureManager.shared)
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissOverrideScreen))
        present(navigationController, animated: true, completion: nil)
    }

    @objc func dismissOverrideScreen(_: Any) {
        dismiss(animated: true, completion: nil)
    }
}
