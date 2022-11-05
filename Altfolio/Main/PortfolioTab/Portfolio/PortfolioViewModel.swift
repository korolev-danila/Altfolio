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
    
    @Published var coinsMap = [Coin]()
    
    @Published var coins = [MyCoin]()
    
    let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    // MARK: - CoreData layer
    func fetchMyCoins() {
        
        let fetchRequest: NSFetchRequest<MyCoin> = MyCoin.fetchRequest()
        
        do {
            coins = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    

    func resetAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCoin")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func save(coin: Coin, amount: String) {
        
        if amount == "" { return }
        
        guard let value = Double(amount) else { return }
        
        if coins.filter({ $0.symbol == coin.symbol }).first != nil {
            
            coins.filter{ $0.symbol == coin.symbol }.first?.amount += value
            
            do {
                try context.save()
                print("save old coin")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "MyCoin", in: context) else { return }
            let myCoin = MyCoin(entity: entity , insertInto: context)
            myCoin.id = coin.id
            myCoin.symbol = coin.symbol
            myCoin.name = coin.name
            myCoin.amount = value
            myCoin.price = 0.0
            myCoin.logoUrl = coin.logoUrl
            
            do {
                try context.save()
                coins.append(myCoin)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }

        updatePrice()

    }
    
    // MARK: - Network layer
    func updatePrice() {
        
        if coins.isEmpty { return }
        print("updatePrice")
        
        var idArray = [String]()
        var idString = ""
        for (index,coin) in self.coins.enumerated() {
            if coin.id == nil { return }
            idArray.append(coin.id!)
            if index == 0 {
                idString += coin.id!
            } else {
                idString += "," + coin.id!
            }
        }
        
        DispatchQueue.main.async {
            
            NetworkManager.shared.fetchPriceArray(idString: idString, idArray: idArray, completion: { dict in
                
                for (index,_) in self.coins.enumerated() {
                    if self.coins[index].id == nil { return }
                    guard let price = dict[self.coins[index].id!] else {
                        print("error guard updatePrice()"); return }
                    self.coins[index].price = price * self.coins[index].amount
                }
                
                do {
                    try self.context.save()
                    print("save new price of coins")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            })
        }
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
