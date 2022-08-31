//
//  NetworkManager.swift
//  Altfolio
//
//  Created by Данила on 30.08.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let apiKey = "" // use CoinMarketCap api key
    
    private init() {}
    
    func fetchMap( completion: @escaping (_ coins: [Coin]) -> ()) {
        let urlBasic = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/map"
        let parameters: Parameters = [
            "start" : "1",
            "limit" : "5",
        ]
        let headers: HTTPHeaders = [
            "Accepts" : "application/json",
            "X-CMC_PRO_API_KEY" : NetworkManager.apiKey
           ]
        guard let url = URL(string: urlBasic) else { return }
        AF.request(url, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                      
                guard let responts = value as? NSDictionary else { return }
                
                guard let data = responts.object(forKey: "data") else { return }
                
                var coins = [Coin]()
                
                coins = Coin.getArray(from: data)!
                
                completion(coins)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchId(id: String, completion: @escaping (() -> Void)) {
        
        let url = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"
        let parameters: Parameters = [
            "id" : id
        ]
        let headers: HTTPHeaders = [
            "Accepts": "application/json",
            "X-CMC_PRO_API_KEY": NetworkManager.apiKey
           ]
        
        guard let url = URL(string: url) else { return }
        AF.request(url, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print("%%%%%%%%%%%%%%%%%%")
                print(value)
                print("%%%%%%%%%%%%%%%%%%")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImg(url: String, completion: @escaping (() -> Void)) {
        
        guard let url = URL(string: url) else { return }
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print("%%%%%%%%%%%%%%%%%%")
                print(value)
                print("%%%%%%%%%%%%%%%%%%")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
