//
//  TransactionCell.swift
//  Altfolio
//
//  Created by Данила on 10.11.2022.
//

import SwiftUI

struct TransactionCell: View {
    
    var trans: Transaction
    
    var symbol: String
    
    func removeZerosFromEnd(_ value: Double) -> String {
            let formatter = NumberFormatter()
            let number = NSNumber(value: value)
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 16
            return String(formatter.string(from: number) ?? "")
        }
    
    var body: some View {
        HStack {
            Text(trans.dateW).padding(.leading , 20.0)
            Spacer()
            Text(
                (trans.addBool ? "+" : "-") + removeZerosFromEnd(trans.amount) + " " + symbol
            )
                .foregroundColor(trans.addBool ? .green : .red)
                .padding(.trailing , 20.0)
            
        }.padding()
    }
}


