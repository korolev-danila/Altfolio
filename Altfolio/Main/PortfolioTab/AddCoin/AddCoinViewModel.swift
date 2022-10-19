//
//  AddCoinViewModel.swift
//  Altfolio
//
//  Created by Данила on 28.08.2022.
//

import Foundation

class AddCoinViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    @Published var selected = Coin(id: "1", name: "Bitcoin", rank: 1, slug: "bitcoin", symbol: "BTC")
    @Published var ticker = "btc"
    @Published var count = ""
    
    func updateSelected() {
        DispatchQueue.main.async {
            NetworkManager.shared.fetchId(id: self.selected.id) { logoString in
                self.selected.logoUrl = logoString[0]
            }
        }
    }
}

