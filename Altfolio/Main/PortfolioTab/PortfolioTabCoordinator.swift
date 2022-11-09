//
//  PortfolioCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import UIKit
import SwiftUI
import CoreData


class PortfolioCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    var viewModel: PortfolioViewModel
    
    public init() {
        
        rootViewController = UINavigationController()
        rootViewController.navigationBar.isHidden = true
        
        viewModel = PortfolioViewModel()
    }
    
    func start() {
        
        //    viewModel.resetAllRecords()
        viewModel.fetchMyCoins()
        viewModel.updateAllPrice()
        
        rootViewController.setViewControllers( [UIHostingController(rootView: portfolioView)] , animated: true)
        
        DispatchQueue.main.async {
            NetworkManager.shared.fetchMap { coins in
                self.viewModel.coinsMap = coins
                self.viewModel.updateURL()
            }
        }
    }
    
    lazy var portfolioView: PortfolioView = {
        var view = PortfolioView(viewModel: viewModel)
        
        view.showAddCoin = { [weak self] in
            self?.showAddCoin()
        }
        
        view.showDetails = { [weak self] coin in
            self?.showDetails(coin: coin)
        }
        return view
    }()
    
    // MARK: - Navigation AddCoin
    func showAddCoin() {
        print("!!!coordinator showAddCoin")
        let addCoinVM = AddCoinViewModel()
        addCoinVM.coins = viewModel.coinsMap
        
        if addCoinVM.selected.logoUrl == "" {
            addCoinVM.updateSelected()
        }
        
        var addCoinView = AddCoinView(viewModel: addCoinVM)
        
        addCoinView.popAddCoin = { [weak self] in
            self?.dismissAddCoin()
        }
        
        addCoinView.saveCoin = { [weak self] in
            self?.save(coin: addCoinVM.selected, amount: addCoinVM.amount )
        }
        
        addCoinView.pushSearch = { [weak self] in
            self?.showSearch(viewModel: addCoinView.viewModel)
        }
        rootViewController.pushViewController(UIHostingController(rootView: addCoinView), animated: true)
    }
    
    func save(coin: CoinOfCMC, amount: String) {
        print("save coin")
        viewModel.save(coin: coin,amount: amount)
        rootViewController.popViewController(animated: true)
    }
    
    func dismissAddCoin() {
        print("pop addCoin")
        rootViewController.popViewController(animated: true)
    }
    
    
    // MARK: - Navigation Search
    func showSearch(viewModel: AddCoinViewModel) {
        print("push Search")
        
        var searchView = SearchView(viewModel: viewModel)
        searchView.popSearchView = { [weak self] in
            self?.dismissSearch()
        }
        
        rootViewController.showDetailViewController(UIHostingController(rootView: searchView), sender: nil)
    }
    
    func dismissSearch() {
        print("pop Search")
        rootViewController.dismiss(animated: true)
    }
    
    // MARK: - Navigation Details
    
    func showDetails(coin: Coin) {
        print("!!!coordinator showDetails")
        guard let coinCD = viewModel.coinsCD.filter({ $0.symbol == coin.symbol }).first else {print("error guard"); return }
        
        let detailsVM = DetailsViewModel(coin: coin ,coinCD: coinCD)
        
        var detailsView = DetailsView(viewModel: detailsVM )
        
        detailsView.popDetails = { [weak self] in
            self?.dismissDetails()
        }
        
        detailsView.popDetailsWithDelete = { [weak self] in
            self?.viewModel.deleteCoin(coin,coinCD)
            self?.dismissDetails()
        }
        
        rootViewController.pushViewController(UIHostingController(rootView: detailsView), animated: true)
        
    }
    
    func dismissDetails() {
        print("pop Details")
        viewModel.updateTotalBalance()
        rootViewController.popViewController(animated: true)
    }
}
