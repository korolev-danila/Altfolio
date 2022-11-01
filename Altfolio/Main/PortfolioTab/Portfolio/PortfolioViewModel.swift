//
//  PortfolioViewModel.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation
import CoreData
import UIKit

class PortfolioViewModel {
    
    @Published var coinsMap = [Coin]()
    
    var coins = [MyCoin]()
  
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
    
    func save(coin: Coin, amount: String) {
        
        if amount == "" { return }
        
        guard let value = Double(amount) else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "MyCoin", in: context) else { return }
        
        let myCoin = MyCoin(entity: entity , insertInto: context)
        myCoin.id = coin.id
        myCoin.symbol = coin.symbol
        myCoin.name = coin.name
        myCoin.amount = value
        myCoin.cost = 0.0
        
        do {
            try context.save()
                coins.append(myCoin)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Network layer
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
