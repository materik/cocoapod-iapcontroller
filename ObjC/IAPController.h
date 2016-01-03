//
//  IAPController.h
//  Pods
//
//  Created by materik on 03/01/16.
//
//

#import "SKProduct+IAPController.h"
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

extern NSString *const IAPControllerFetchedNotification;
extern NSString *const IAPControllerPurchasedNotification;
extern NSString *const IAPControllerFailedNotification;
extern NSString *const IAPControllerRestoredNotification;

@interface IAPController : NSObject

@property(nonatomic, readonly) NSArray<SKProduct *> *products;

- (void)fetchProducts;
- (void)restore;

+ (IAPController *)sharedInstance;

@end
