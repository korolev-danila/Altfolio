//
//  PortfolioViewModel.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation
import CoreData
import UIKit

class PortfolioViewModel: ObservableObject {
    
    @Published var coinsMap = [CoinOfCMC]()
    
    @Published var coinsCD = [CoinCD]()
    
    @Published var coins = [Coin]()
    
    @Published var totalBalance: Int = 0
    
    var timer: Timer?
    
    let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    // MARK: - CoreData layer
    func fetchMyCoins() {
        
        let fetchRequest: NSFetchRequest<CoinCD> = CoinCD.fetchRequest()
        
        do {
            coinsCD = try context.fetch(fetchRequest)
            
            for coin in coinsCD {
                coins.append(initCoin(coin))
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func initCoin(_ coin: CoinCD) -> Coin {
        let coin = Coin(id: coin.id ?? "1", name: coin.name ?? "", symbol: coin.symbol ?? "", logoUrl: coin.logoUrl ?? "", amount: coin.amount , price: coin.price)
        
        return coin
    }
    
    func resetAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoinCD")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func save(coin: CoinOfCMC, amount: String) {
        
        if amount == "" { return }
        
        guard let value = Double(amount) else { return }
        
        if coinsCD.filter({ $0.symbol == coin.symbol }).first != nil {
            do {
                coins.filter{ $0.symbol == coin.symbol }.first?.amount += value
                coinsCD.filter{ $0.symbol == coin.symbol }.first?.amount += value
                updateTotalBalance()
                try context.save()
                print("save old coin")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "CoinCD", in: context) else { return }
            let myCoin = CoinCD(entity: entity , insertInto: context)
            myCoin.id = coin.id
            myCoin.symbol = coin.symbol
            myCoin.name = coin.name
            myCoin.amount = value
            myCoin.price = 0.0
            myCoin.logoUrl = coin.logoUrl
            
            do {
                try context.save()
                coinsCD.append(myCoin)
                coins.append(initCoin(myCoin))
                fetchPrice(coinId: coin.id)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCoin(_ coin: Coin,_ coinCD: CoinCD) {
        
        context.delete(coinCD)
        
        do {
            try context.save()
            if let index = coins.firstIndex(of: coin ) {
                coins.remove(at: index)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - update totalBalance
    func updateTotalBalance() {
        var total: Double = 0.0
        for coin in coins {
            total += (coin.price * coin.amount)
        }
        totalBalance = Int(total)
    }
    
    // MARK: - Network layer
    @objc func updateAllPrice() {
        
        if coinsCD.isEmpty { return }
        
        if  timer == nil {
            let timer = Timer(timeInterval: 30.0,
                              target: self,
                              selector: #selector(updateAllPrice),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            
            self.timer = timer
        }
        
        print("updateAllPrice")
        
        var idArray = [String]()
        var idString = ""
        for (index,coin) in self.coins.enumerated() {
            //  if coin.id == nil { return }
            idArray.append(coin.id)
            if index == 0 {
                idString += coin.id
            } else {
                idString += "," + coin.id
            }
        }
        
        DispatchQueue.main.async {
            NetworkManager.shared.fetchPriceArray(idString: idString, idArray: idArray, completion: { dict in
                
                for (index,_) in self.coinsCD.enumerated() {
                    if self.coinsCD[index].id == nil { return }
                    guard let price = dict[self.coins[index].id] else {
                        print("error guard updatePrice()"); return }
                    self.coinsCD[index].price = price
                    self.coins[index].price = price
                    self.updateTotalBalance()
                }
                
                do {
                    try self.context.save()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    func fetchPrice(coinId: String) {
        NetworkManager.shared.fetchPriceArray(idString: coinId, idArray: [coinId], completion: { dict in
            print(" newPrice of newCoin ")
            self.coins.filter{ $0.id == coinId }.first?.price = dict[coinId] ?? 0.0
            self.updateTotalBalance()
        })
    }
    
    func updateURL() {
        print(" func updateURL")
        var idArray = [String]()
        var idString = ""
        for (index,coin) in self.coinsMap.enumerated() {
            idArray.append(coin.id)
            if index == 0 {
                idString += coin.id
            } else {
                idString += "," + coin.id
            }
        }
        
        DispatchQueue.main.async {
            NetworkManager.shared.fetchLogoUrlArray(idString: idString, idArray: idArray, completion: { dict in
                for (index,_) in self.coinsMap.enumerated() {
                    guard let urlStr = dict[self.coinsMap[index].id] else {
                        print("error guard updateURL()"); return }
                    self.coinsMap[index].logoUrl = urlStr
                }
            })
        }
    }
    
}
