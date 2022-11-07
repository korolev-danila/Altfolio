//
//  AddCoinViewModel.swift
//  Altfolio
//
//  Created by Данила on 28.08.2022.
//

import Foundation
import CoreData

class AddCoinViewModel: ObservableObject {
    
    @Published var coins = [CoinOfCMC]()
    
    @Published var selected = CoinOfCMC(id: "1", name: "Bitcoin", rank: 1, slug: "bitcoin", symbol: "BTC")
    @Published var ticker = "btc"
    @Published var amount = ""
    @Published var searchText = ""
    
    var searchResults: [CoinOfCMC] {
           if searchText.isEmpty {
               return coins
           } else {
               return coins.filter { $0.name.hasPrefix(searchText) || $0.symbol.hasPrefix(searchText)  }
           }
       }
    
    func updateSelected() {
        DispatchQueue.main.async {
            NetworkManager.shared.fetchLogoURL(id: self.selected.id) { logoString in
                self.selected.logoUrl = logoString[0]
            }
        }
    }
}

