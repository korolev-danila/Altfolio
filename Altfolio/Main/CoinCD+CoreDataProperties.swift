//
//  CoinCD+CoreDataProperties.swift
//  Altfolio
//
//  Created by Данила on 10.11.2022.
//
//

import Foundation
import CoreData


extension CoinCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoinCD> {
        return NSFetchRequest<CoinCD>(entityName: "CoinCD")
    }

    @NSManaged public var amount: Double
    @NSManaged public var id: String?
    @NSManaged public var logoUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var symbol: String?
    @NSManaged public var history: NSSet?
    
    public var idW: String {
        id ?? "Unknow"
    }
    
    public var logoUrlW: String {
        logoUrl ?? "Unknow logo"
    }
    
    public var nameW: String {
        name ?? "Unknow name"
    }
    
    public var symbolW: String {
        symbol ?? "Unknow symbol"
    }
    
    public var historyArray: [Transaction] {
        let set = history as? Set<Transaction> ?? []
        
        return set.sorted {
            $0.dateW < $1.dateW
        }
    }

}

// MARK: Generated accessors for history
extension CoinCD {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: Transaction)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: Transaction)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

extension CoinCD : Identifiable {

}
