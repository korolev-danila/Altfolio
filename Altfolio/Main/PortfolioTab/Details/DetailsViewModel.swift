//
//  DetailsViewModel.swift
//  Altfolio
//
//  Created by Данила on 07.11.2022.
//

import Foundation
import CoreData
import UIKit

class DetailsViewModel {
    
    var coin: Coin
    var coinCD: CoinCD
    
    let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
//    init(coin: Coin) {
//        self.coin = coin
//
//    }
    
    init(coin: Coin,coinCD: CoinCD) {
        self.coin = coin
        self.coinCD = coinCD
    }
}
