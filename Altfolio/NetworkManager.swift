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
    
    let headers: HTTPHeaders = [
        "Accepts": "application/json",
        "X-CMC_PRO_API_KEY": "e90479d1-ff9e-4551-85bc-fb25b4863739" // use CoinMarketCap api key
    ]
    
    private init() {}
    
    func fetchMap( completion: @escaping (_ coins: [Coin]) -> ()) {
        let urlBasic = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/map"
        let parameters: Parameters = [
            "start" : "1",
            "limit" : "1000",
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
    
    func fetchLogoURL(id: String, completion: @escaping (_ logoString: [String]) -> ()) {
        
        let url = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"
        let parameters: Parameters = [
            "id" : id ,
            "aux" : "logo"
        ]
        
        guard let url = URL(string: url) else { return }
        AF.request(url, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let responts = value as? NSDictionary else { return }
                guard let data = responts.object(forKey: "data") as? NSDictionary else { return }
                guard let idData = data.object(forKey: id) as? NSDictionary else { return }
                guard let string = idData.object(forKey: "logo") as? String else { return }
                
                let arrStr = [string]
                completion(arrStr)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchLogoUrlArray(idString: String, idArray: [String], completion: @escaping (_ logoDict: [String:String]) -> ()) {
        
        let url = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"
        let parameters: Parameters = [
            "id" : idString ,
            "aux" : "logo"
        ]

        guard let url = URL(string: url) else { return }
        AF.request(url, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                guard let responts = value as? NSDictionary else { return }
                guard let data = responts.object(forKey: "data") as? NSDictionary else { return }
                
                var dict = [String:String]()
                
                for id in idArray {
                    guard let idData = data.object(forKey: id) as? NSDictionary else { return }
                    guard let string = idData.object(forKey: "logo") as? String else { return }
                    dict[id] = string
                }
                
                completion(dict)
                
            case .failure(let error):
                print("Request failed with error \(error)")
            }
        }
    }
    
    func fetchImg(url: String, completion: @escaping (_ imageData: Data) -> ()) {
        
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
