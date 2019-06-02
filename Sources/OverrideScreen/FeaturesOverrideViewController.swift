//
//  FeaturesOverrideViewController.swift
//  Shunter
//
//  Created by Wojciech Chojnacki on 12/05/2019.
//  Copyright © 2019 Wojciech Chojnacki. All rights reserved.
//

#if canImport(UIKit)
import UIKit

open class FeaturesOverrideViewController: UITableViewController {
    let defaultReuseIdentifier = "Default"

    fileprivate enum FeatureStatus {
        case overrided(Bool)
        case notOverrided(Bool)
    }

    fileprivate struct CellViewModel {
        let identifier: Feature.Identifier
        let name: String
        let description: String
        let status: FeatureStatus
    }

    private let featureManager: FeatureManager

    private var cellViewModels = [CellViewModel]()

    public init(featureManager: FeatureManager) {
        self.featureManager = featureManager
        super.init(style: .grouped)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("FeatureOverride.Title", bundle: Bundle(for: type(of: self)), comment: "")

        cellViewModels = featureManager.allFeatures.map {
            let value = featureManager.isEnabled($0)
            let status: FeatureStatus = featureManager.isOverrided($0) ? .overrided(value) : .notOverrided(value)
            return CellViewModel(identifier: $0.identifier,
                          name: $0.identifier,
                          description: $0.comment ?? "",
                          status: status)
        }

        tableView.register(FeatureViewCell.self, forCellReuseIdentifier: defaultReuseIdentifier)
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier, for: indexPath) as? FeatureViewCell else {
            fatalError("Missing cell")
        }

        let viewModel = cellViewModels[indexPath.row]
        cell.populate(with: viewModel)
        cell.delegate = self
        return cell
    }

}

extension FeaturesOverrideViewController: FeatureViewCellDelegate {
    fileprivate func featureViewCell(_ cell: FeatureViewCell, didSelectValue value: Bool?) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let viewModel = cellViewModels[indexPath.row]
        let feature = Feature(viewModel.identifier)
        featureManager.override(feature: feature, value: value)
    }
}

private protocol FeatureViewCellDelegate: class {
    func featureViewCell(_ cell: FeatureViewCell, didSelectValue: Bool?)
}

private class FeatureViewCell: UITableViewCell {
    private var segments: UISegmentedControl!
    weak var delegate: FeatureViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: nil)

        let segments = UISegmentedControl(items: ["T", "F", "D"])
        accessoryView = segments
        self.segments = segments

        segments.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(with viewModel: FeaturesOverrideViewController.CellViewModel) {
        self.textLabel?.text = viewModel.name
        self.detailTextLabel?.text = viewModel.description
        switch viewModel.status {
        case let .overrided(value):
            segments.selectedSegmentIndex = value ? 0 : 1
        case .notOverrided:
            segments.selectedSegmentIndex = 2
        }
    }

    @objc private func segmentAction(_ sender: UISegmentedControl) {
        let value: Bool?
        if sender.selectedSegmentIndex == 0 {
            value = true
        } else if sender.selectedSegmentIndex == 1 {
            value = false
        } else {
            value = nil
        }

        delegate?.featureViewCell(self, didSelectValue: value)
    }
}

#endif
