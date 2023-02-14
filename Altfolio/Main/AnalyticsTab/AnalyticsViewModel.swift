//
//  AnalyticsViewModel.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation

struct PartPie {
    var id = UUID()
    var symbol: String
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    var percent : CGFloat
    var value : CGFloat
}

final class AnalyticsViewModel: ObservableObject {
    private let coreData: CoreDataProtocol
    
    private var coinsCD = [CoinCD]()
    @Published var pieArr = [PartPie]()
    
    private var totalBalance = 0.0
    
    init(coreData: CoreDataProtocol) {
        self.coreData = coreData
    }
    
    func calc() {
        var value: CGFloat = 0
        
        for i in 0..<pieArr.count {
            value += pieArr[i].percent
            pieArr[i].value = value
        }
    }
    
    func fetchMyCoins() {
        coinsCD = coreData.fetchMyCoins()
        updateTotalBalance()
        calculPercentages()
    }
    
    private func updateTotalBalance() {
        var total: Double = 0.0
        
        for coin in coinsCD {
            total += (coin.price * coin.amount)
        }
        totalBalance = total
    }
    
    private func calculPercentages() {
        pieArr.removeAll()
        let onePercent = totalBalance / 100.0
        
        for coin in coinsCD {
            pieArr.append(PartPie(symbol: coin.symbolW, r: random(), g: random(), b: random(),
                                  percent: (coin.price * coin.amount) / onePercent, value: 0))
        }
    }
    
    private func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
