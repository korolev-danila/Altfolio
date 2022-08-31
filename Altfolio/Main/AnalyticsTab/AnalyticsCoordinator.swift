//
//  AnalyticsCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import UIKit
import SwiftUI

class AnalyticsCoordinator: Coordinator {
    
    
    var rootViewController: UINavigationController
    
    var viewModel: AnalyticsViewModel
    
    public init() {
        
        rootViewController = UINavigationController()
        rootViewController.navigationBar.backgroundColor = .blue
        rootViewController.navigationBar.prefersLargeTitles = false
        rootViewController.isNavigationBarHidden = false
        viewModel = AnalyticsViewModel()
    }

    func start() {

        let view = AnalyticsView()
        rootViewController.setViewControllers( [UIHostingController(rootView: view)] , animated: true)
    }
}
