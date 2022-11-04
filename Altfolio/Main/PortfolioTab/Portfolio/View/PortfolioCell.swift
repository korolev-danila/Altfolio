//
//  PortfolioCell.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import SwiftUI

struct PortfolioCell: View {
    
    var object: MyCoin!
    
    func removeZerosFromEnd(_ value: Double) -> String {
            let formatter = NumberFormatter()
            let number = NSNumber(value: value)
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 16
            return String(formatter.string(from: number) ?? "")
        }
    
    var body: some View {
        HStack {
            AsyncImg(url: object.logoUrl ?? "https://upload.wikimedia.org/wikipedia/commons/4/46/Bitcoin.svg")
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Text(object.symbol!)
                        .font(.title)
                    Text(object.name!)
                }
                Text(removeZerosFromEnd(object.amount))
            }
            Spacer()
            Text(removeZerosFromEnd(object.cost))
        }
        .frame( height: 85)
    }
}
