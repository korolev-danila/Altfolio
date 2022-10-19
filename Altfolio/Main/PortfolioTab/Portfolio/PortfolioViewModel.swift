//
//  PortfolioViewModel.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation

class PortfolioViewModel {
    
    @Published var coinsMap = [Coin]()
  
    func updateURL() {
        
        var idArray = [String]()
        var idString = ""
        print(" func updateURL")
        for (index,coin) in self.coinsMap.enumerated() {
            idArray.append(coin.id)
            if index == 0 {
                idString += coin.id
            } else {
                idString += "," + coin.id
            }
        }
        print(" func updateURL disptchQueue")
//        idArray = ["1","2","3","4","5","6"]
//        idString = "1,2,3,4,5,6"
        
        DispatchQueue.main.async {
            
            NetworkManager.shared.fetchIdArray(idString: idString, idArray: idArray, completion: { dict in
                
                for (index,_) in self.coinsMap.enumerated() {
                    guard let urlStr = dict[self.coinsMap[index].id] else {
                        print("error guard updateURL()"); return }
                    self.coinsMap[index].logoUrl = urlStr
                }
               
            })
        }
    }
    
}
