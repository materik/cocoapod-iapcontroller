![](logo.png)

[![](https://img.shields.io/badge/contact-@thematerik-blue.svg?style=flat-square)](http://twitter.com/thematerik)
[![](https://img.shields.io/cocoapods/v/IAPController.svg?style=flat-square)](https://cocoapods.org/pods/IAPController)
![](https://img.shields.io/cocoapods/p/IAPController.svg?style=flat-square)
![](https://img.shields.io/cocoapods/l/IAPController.svg?style=flat-square)

In App Purchase controller

# Install

```bash
pod 'IAPController'
```

## Swift (Default)

```bash
pod 'IAPController/Swift'
```

## Objective-C

```bash
pod 'IAPController/ObjC'
```

# Usage

Create a plist-file named `IAPControllerProductIds.plist` that contains the identifiers of your in-app purchases:

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
  <string>com.thematerik.IAPController.product1</string>
  <string>com.thematerik.IAPController.product2</string>
</array>
</plist>
```

Fetch the products in the `didFinishLaunchingWithOptions` method in your `AppDelegate`:

```swift
IAPController.sharedInstance.fetchProducts()
```

Use observers to listen to in-app purchases events:

* `IAPControllerFetchedNotification`: when the products have been fetched from the store
* `IAPControllerPurchasedNotification`: when a product have been purchased
* `IAPControllerFailedNotification`: when a transaction could not be finished
* `IAPControllerRestoredNotification`: when the user restored his in-app purchases

`SKProduct` have been given some useful helper methods, example:

```swift
if let product = IAPController.sharedInstance.products?.first {
    // Printing the price of the product
    print(product.priceFormatted)
    // Buying the product
    product.buy()
}
```

Restore purchases by calling:

```swift
IAPController.sharedInstance.restore()
```

*The same API call works for `Objective-C` as well*
