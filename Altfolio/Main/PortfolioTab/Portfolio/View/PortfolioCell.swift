//
//  PortfolioCell.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import SwiftUI

struct PortfolioCell: View {
    
    @ObservedObject var object: Coin
    
    func removeZerosFromEnd(_ value: Double) -> String {
            let formatter = NumberFormatter()
            let number = NSNumber(value: value)
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 16
            return String(formatter.string(from: number) ?? "")
        }
    
    var body: some View {
        HStack {
            AsyncImg(url: object.logoUrl )
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Text(object.symbol )
                        .font(.title)
                    Text(object.name )
                }
                Text(removeZerosFromEnd(object.amount))
            }
            Spacer()
            Text(String(format: "%.2f", (object.price * object.amount)) + "$")
        }
        .frame( height: 85)
    }
}
