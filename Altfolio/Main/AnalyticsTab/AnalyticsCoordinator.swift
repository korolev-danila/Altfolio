//
//  AnalyticsCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import UIKit
import SwiftUI

class AnalyticsCoordinator {
    
    var rootViewController: UINavigationController
    private var viewModel: AnalyticsViewModel
    
    private let coreData: CoreDataProtocol
    private let network: NetworkProtocol
    
    private lazy var analyticsView: AnalyticsView = {
        var view = AnalyticsView(viewModel: viewModel)
        return view
    }()
    
    init(coreData: CoreDataProtocol, network: NetworkProtocol) {
        self.coreData = coreData
        self.network = network
        rootViewController = UINavigationController()
        rootViewController.navigationBar.backgroundColor = .blue
        rootViewController.navigationBar.prefersLargeTitles = false
        rootViewController.isNavigationBarHidden = false
        viewModel = AnalyticsViewModel()
    }
}

// MARK: - CoordinatorProtocol
extension AnalyticsCoordinator: CoordinatorProtocol {
    func start() {
        rootViewController.setViewControllers( [UIHostingController(rootView: analyticsView)] , animated: true)
    }
}
