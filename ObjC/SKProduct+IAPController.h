//
//  SKProduct+IAPController.h
//  Pods
//
//  Created by materik on 03/01/16.
//
//

#import <StoreKit/StoreKit.h>

@interface SKProduct (IAPController)

- (NSString *)priceFormatted;
- (void)buy;

@end
