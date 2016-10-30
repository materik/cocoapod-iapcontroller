//
//  IAPController.swift
//  XWorkout
//
//  Created by materik on 19/07/15.
//  Copyright (c) 2015 materik. All rights reserved.
//

import Foundation
import StoreKit

public let IAPControllerFetchedNotification = "IAPControllerFetchedNotification"
public let IAPControllerPurchasedNotification = "IAPControllerPurchasedNotification"
public let IAPControllerFailedNotification = "IAPControllerFailedNotification"
public let IAPControllerRestoredNotification = "IAPControllerRestoredNotification"

open class IAPController: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // MARK: Properties
    
    open var products: [SKProduct]?
    var productIds: [String] = []
    
    // MARK: Singleton
    
    open static var sharedInstance: IAPController = {
        return IAPController()
    }()
    
    // MARK: Init
    
    public override init() {
        super.init()
        self.retrieveProductIdsFromPlist()
        SKPaymentQueue.default().add(self)
    }
    
    private func retrieveProductIdsFromPlist() {
        let url = Bundle.main.url(forResource: "IAPControllerProductIds", withExtension: "plist")!
        self.productIds = NSArray(contentsOf: url) as! [String]
    }
    
    // MARK: Action
    
    open func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(self.productIds))
        request.delegate = self
        request.start()
    }
    
    open func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: SKPaymentTransactionObserver

    open func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        NotificationCenter.default.post(name: Notification.Name(rawValue: IAPControllerFetchedNotification), object: nil)
    }
    
    open func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                self.purchasedTransaction(transaction: transaction)
                break
            case .failed:
                self.failedTransaction(transaction: transaction)
                break
            case .restored:
                self.restoreTransaction(transaction: transaction)
                break
            default:
                break
            }
        }
    }
    
    open func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        self.failedTransaction(transaction: nil, error: error)
    }
    
    open func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: IAPControllerRestoredNotification), object: nil)
    }
    
    // MARK: Transaction
    
    func finishTransaction(transaction: SKPaymentTransaction? = nil) {
        if let transaction = transaction {
            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }
    
    func restoreTransaction(transaction: SKPaymentTransaction? = nil) {
        self.finishTransaction(transaction: transaction)
        NotificationCenter.default.post(name: Notification.Name(rawValue: IAPControllerPurchasedNotification), object: nil)
    }
    
    func failedTransaction(transaction: SKPaymentTransaction? = nil, error: Error? = nil) {
        self.finishTransaction(transaction: transaction)
        if let error = error ?? transaction?.error {
            if error._code != SKError.paymentCancelled.rawValue {
                NotificationCenter.default.post(name: Notification.Name(rawValue: IAPControllerFailedNotification), object: error)
            }
        }
    }
    
    func purchasedTransaction(transaction: SKPaymentTransaction? = nil) {
        self.finishTransaction(transaction: transaction)
        NotificationCenter.default.post(name: Notification.Name(rawValue: IAPControllerPurchasedNotification), object: nil)
    }
    
}

