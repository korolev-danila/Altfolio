//
//  DetailsViewModel.swift
//  Altfolio
//
//  Created by Данила on 07.11.2022.
//

import Foundation

class DetailsViewModel: ObservableObject {
    private let coreData: CoreDataProtocol
    
    @Published var coin: Coin
    @Published var coinCD: CoinCD
    @Published var history: Array<Transaction>
    @Published var value: String = ""
    
    init(coin: Coin, coinCD: CoinCD, coreData: CoreDataProtocol) {
        self.coin = coin
        self.coinCD = coinCD
        self.history = coinCD.historyArray
        self.coreData = coreData
    }
    
    func saveValue(addBool: Bool) {
        guard let amount = Double(value) else { return }
        
        if addBool {
            coin.amount += amount
            coinCD.amount += amount
        } else {
            coin.amount -= amount
            coinCD.amount -= amount
        }
        
        guard let trans = coreData.createTrans(value: amount) else { return }
        trans.addBool = addBool
        coinCD.addToHistory(trans)
        history = coinCD.historyArray
        coreData.saveContext()
    }
}
