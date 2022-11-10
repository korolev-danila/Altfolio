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
    
    @Published var coin: Coin
    @Published var coinCD: CoinCD
    @Published var history: Array<Transaction>
        
    
    
    @Published var value: String = ""
    
    let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    init(coin: Coin,coinCD: CoinCD) {
        self.coin = coin
        self.coinCD = coinCD
        self.history  = coinCD.historyArray
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
            guard let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: context) else { return }
            let trans = Transaction(entity: entity , insertInto: context)
            trans.date = Date()
            trans.amount = amount
            trans.addBool = addBool
            coinCD.addToHistory(trans)
            self.history  = coinCD.historyArray
            
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
