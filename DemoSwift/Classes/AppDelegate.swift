//
//  AppDelegate.swift
//  IAPController
//
//  Created by materik on 23/07/15.
//
//

import UIKit
import IAPController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IAPController.sharedInstance.fetchProducts()
        IAPController.sharedInstance.products?.first?.buy()
        
        return true
    }
    
}
