//
//  Transaction+CoreDataProperties.swift
//  Altfolio
//
//  Created by Данила on 10.11.2022.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var addBool: Bool
    @NSManaged public var relationship: CoinCD?
    
    public var dateW: String {
        let dateForm = DateFormatter()
        let d = date ?? Date()
        
        dateForm.dateFormat = "dd/MM/YY - HH:mm:ss"
        
        return dateForm.string(from: d)
        
    }

}

extension Transaction : Identifiable {

}
