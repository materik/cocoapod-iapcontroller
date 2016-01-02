![](logo.png)

[![](https://img.shields.io/cocoapods/v/IAPController.svg?style=flat-square)](https://cocoapods.org/pods/IAPController)
![](https://img.shields.io/cocoapods/p/IAPController.svg?style=flat-square)
![](https://img.shields.io/cocoapods/l/IAPController.svg?style=flat-square)

In App Purchase controller for Swift

# Install

Install it with Cocoapods :
```
pod 'IAPController'
```

If you're using Swift 2 with Xcode 7, consider to use version 0.2.0 instead
```
pod 'IAPController', :git => "https://github.com/materik/IAPController.git", :tag => "0.2.0"
```
# Usage
Create a plist file named `IAPControllerProductIds.plist` that will contain the identifiers of your in-app purchases :
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
  <string>BundleIdentifier.IAP1</string>
  <string>BundleIdentifier.IAP2</string>
  <string>BundleIdentifier.IAP3</string>
  <string>BundleIdentifier.IAP4</string>
</array>
</plist>
```

You should start by fetching products on the store :
```
IAPController.sharedInstance.fetchProducts()
```

Use observers to responds to the IAP NSNotificationCenter events :
* `IAPControllerFetchedNotification` : when the products have been fetched from the store. (You should reload your view controller with price and IAP informations)
* `IAPControllerPurchasedNotification` : when a product have been purchased (you should give the user what he purchased here)
* `IAPControllerFailedNotification` : when a transaction could not be finished
* `IAPControllerRestoredNotification` : when the user restored his in-app purchases

# SKProduct extensions
You can call on any SKProduct some new helper functions :
```
let product = IAPController.sharedInstance.products!.first!

// Printing the price of the product
print(product.priceFormatted)

// Buying the product
product.buy()
```

The buy should be treated in a function called by an observer on IAPControllerPurchasedNotification

# Restoring purchases
```
IAPController.sharedInstance.restore()
```
