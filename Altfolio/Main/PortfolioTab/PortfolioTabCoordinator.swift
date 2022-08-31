//
//  PortfolioCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import UIKit
import SwiftUI

class PortfolioCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    var viewModel: PortfolioViewModel
    
    public init() {
        
        rootViewController = UINavigationController()
        rootViewController.navigationBar.isHidden = true
        
        viewModel = PortfolioViewModel()
      //  rootViewController.delegate = self
    }
    
    func start() {
        rootViewController.setViewControllers( [UIHostingController(rootView: portfolioView)] , animated: true)
    }
    
    lazy var portfolioView: PortfolioView = {
        var view = PortfolioView(viewModel: viewModel)
         
        view.showAddCoin = { [weak self] in
            self?.showAddCoin()

        }
        
        return view
    }()
    
    // MARK: - Navigation AddCoin
    func showAddCoin() {
        print("!!!coordinator")
        let addCoinVM = AddCoinViewModel()
        var addCoinView = AddCoinView(viewModel: addCoinVM)
        addCoinView.popAddCoin = { [weak self] in
            self?.dismissAddCoin()
        }
        addCoinView.pushSearch = { [weak self] in
            self?.showSearch(viewModel: addCoinView.viewModel)
        }
        rootViewController.pushViewController(UIHostingController(rootView: addCoinView), animated: true)
        NetworkManager.shared.fetchMap { coins in
            print(coins[0])
        }
    }
    
    func dismissAddCoin() {
        print("pop addCoin")
        rootViewController.popViewController(animated: true)
    }
    
    // MARK: - Navigation Search
    func showSearch(viewModel: AddCoinViewModel) {
        print("push Search")
        
        let searchVC = UIHostingController(rootView: SearchView(viewModel: viewModel))
        
        rootViewController.showDetailViewController(searchVC, sender: nil)
    }
}
