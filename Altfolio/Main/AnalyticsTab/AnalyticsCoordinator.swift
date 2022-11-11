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
    
    lazy var analyticsView: AnalyticsView = {
        var view = AnalyticsView(viewModel: viewModel)
        
        return view
    }()

    func start() {


        rootViewController.setViewControllers( [UIHostingController(rootView: analyticsView)] , animated: true)
    }
}
