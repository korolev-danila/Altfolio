//
//  PortfolioCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import UIKit
import SwiftUI

final class PortfolioCoordinator {
    var rootViewController: UINavigationController
    private var viewModel: PortfolioViewModel
    
    private let coreData: CoreDataProtocol
    private let network: NetworkProtocol
    
    private lazy var portfolioView: PortfolioView = {
        var view = PortfolioView(viewModel: viewModel)
        
        view.showAddCoin = { [weak self] in
            self?.showAddCoin()
        }
        view.showDetails = { [weak self] coin in
            self?.showDetails(coin: coin)
        }
        return view
    }()
    
    init(coreData: CoreDataProtocol, network: NetworkProtocol) {
        self.coreData = coreData
        self.network = network
        rootViewController = UINavigationController()
        rootViewController.navigationBar.isHidden = true
        viewModel = PortfolioViewModel(coreData: coreData, network: network)
    }
    
    // MARK: - Navigation AddCoin
    private func showAddCoin() {
        let addCoinVM = AddCoinViewModel(network: network)
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
    
    private func save(coin: CoinOfCMC, amount: String) {
        viewModel.save(coin: coin, amount: amount)
        rootViewController.popViewController(animated: true)
    }
    
    private func dismissAddCoin() {
        rootViewController.popViewController(animated: true)
    }
    
    // MARK: - Navigation Search
    private func showSearch(viewModel: AddCoinViewModel) {
        var searchView = SearchView(viewModel: viewModel)
        searchView.popSearchView = { [weak self] in
            self?.dismissSearch()
        }
        rootViewController.showDetailViewController(UIHostingController(rootView: searchView), sender: nil)
    }
    
    private func dismissSearch() {
        rootViewController.dismiss(animated: true)
    }
    
    // MARK: - Navigation Details
    private func showDetails(coin: Coin) {
        guard let coinCD = viewModel.coinsCD.filter({ $0.symbol == coin.symbol }).first else {print("error guard"); return }
        
        let detailsVM = DetailsViewModel(coin: coin ,coinCD: coinCD, coreData: coreData)
        var detailsView = DetailsView(viewModel: detailsVM )
        
        detailsView.popDetails = { [weak self] in
            self?.dismissDetails()
        }
        detailsView.popDetailsWithDelete = { [weak self] in
            self?.coreData.deleteCoin(coinCD)
            self?.viewModel.fetchMyCoins()
            self?.dismissDetails()
        }
        
        rootViewController.pushViewController(UIHostingController(rootView: detailsView), animated: true)
    }
    
    private func dismissDetails() {
        print("pop Details")
        viewModel.updateTotalBalance()
        rootViewController.popViewController(animated: true)
    }
}

// MARK: - CoordinatorProtocol
extension PortfolioCoordinator: CoordinatorProtocol {
    func start() {
        //    viewModel.resetAllRecords()
        viewModel.fetchMyCoins()
        viewModel.updateAllPrice()
        
        rootViewController.setViewControllers( [UIHostingController(rootView: portfolioView)] , animated: true)
        
        DispatchQueue.main.async {
            self.network.fetchMap { [weak self] coins in
                guard let _self = self else { return }
                _self.viewModel.coinsMap = coins
                _self.viewModel.updateURL()
            }
        }
    }
}
