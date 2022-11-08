//
//  DetailsViewModel.swift
//  Altfolio
//
//  Created by Данила on 07.11.2022.
//

import Foundation
import CoreData
import UIKit

class DetailsViewModel: ObservableObject {
    
    var coin: Coin
    var coinCD: CoinCD

    @Published var value: String = ""
    
    let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    init(coin: Coin,coinCD: CoinCD) {
        self.coin = coin
        self.coinCD = coinCD
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
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
