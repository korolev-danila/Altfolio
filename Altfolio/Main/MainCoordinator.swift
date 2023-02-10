//
//  MainCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation
import UIKit
import SwiftUI

final class MainCoordinator {
    
    var rootViewController: UITabBarController
    private var childCoordinator = [CoordinatorProtocol]()
    
    init() {
        rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
    }
    
    private func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}

extension MainCoordinator: CoordinatorProtocol {
    func start() {
        let portfolioCoordinator = PortfolioCoordinator()
        portfolioCoordinator.start()
        childCoordinator.append(portfolioCoordinator)
        let portfolioView = portfolioCoordinator.rootViewController
        setup(vc: portfolioView, title: "Home", imageName: "paperplane", selectedImageName: "paperplane.fill")
        
        let analyticsCoordinator = AnalyticsCoordinator()
        analyticsCoordinator.start()
        childCoordinator.append(analyticsCoordinator)
        let analyticsView = analyticsCoordinator.rootViewController
        setup(vc: analyticsView, title: "Analytics", imageName: "bell", selectedImageName: "bell.fill")
        
        rootViewController.viewControllers = [portfolioView, analyticsView]
    }
}
