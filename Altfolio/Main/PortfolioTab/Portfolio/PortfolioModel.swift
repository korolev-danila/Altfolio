//
//  PortfolioModel.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation

struct Bitcoin: Hashable, Codable, Identifiable {
    
    var id: Int
    var ticker: String
    var name: String
    var cost: Float
    var volume: Float
    var imageData: Data
}
