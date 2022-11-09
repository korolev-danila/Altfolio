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
                        .scaledToFill()
                        .lineLimit(1)
                        .minimumScaleFactor(5)
                    Text(object.name )
                        .scaledToFill()
                        .lineLimit(1)
                        .minimumScaleFactor(1)
                }
                Text(removeZerosFromEnd(object.amount))
                    .scaledToFill()
                    .minimumScaleFactor(0.0005)
                    .lineLimit(1)
            }
            Spacer()
            Text(String(format: "%.2f", (object.price * object.amount)) + "$")
                .font(.title3)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .frame( height: 85)
    }
}
