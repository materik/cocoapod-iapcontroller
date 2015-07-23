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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        IAPController.sharedInstance.fetchProducts()
        IAPController.sharedInstance.products?.first?.buy()
        return true
    }
    
}
