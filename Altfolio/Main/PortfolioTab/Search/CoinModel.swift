//
//  CoinModel.swift
//  Altfolio
//
//  Created by Данила on 31.08.2022.
//

import Foundation

//struct Response: Codable {
//    var data: [Coin]
//
//    init?(json: [String: Array]) {
//        let data = json["data"] as? Array
//
//        self.data = data
//    }
//}

struct Coin: Codable {
    
    let id: Int
    let name: String
    let rank: Int
    let slug: String
    let symbol: String
    
    init?(json: [String: Any]) {
        
        let id = json["id"] as! Int
        let name = json["name"] as! String
        let rank = json["rank"] as! Int
        let slug = json["slug"] as! String
        let symbol = json["symbol"] as! String
        
        self.id = id
        self.name = name
        self.rank = rank
        self.slug = slug
        self.symbol = symbol
    }
    
    static func getArray(from jsonArray: Any) -> [Coin]? {
        
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil}
        
        return jsonArray.compactMap { Coin(json: $0)}
    }
}
