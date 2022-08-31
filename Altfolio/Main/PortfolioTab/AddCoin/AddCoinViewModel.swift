//
//  AddCoinViewModel.swift
//  Altfolio
//
//  Created by Данила on 28.08.2022.
//

import Foundation

class AddCoinViewModel: ObservableObject {
    
    @Published var ticker = "btc"
    @Published var count = ""
}
