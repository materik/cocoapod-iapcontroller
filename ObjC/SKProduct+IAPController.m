//
//  SKProduct+IAPController.m
//  Pods
//
//  Created by materik on 03/01/16.
//
//

#import "SKProduct+IAPController.h"

@implementation SKProduct (IAPController)

- (NSString *)priceFormatted {
  NSNumberFormatter *priceFormatter = [[NSNumberFormatter alloc] init];
  [priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
  [priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [priceFormatter setLocale:self.priceLocale];
  return [priceFormatter stringFromNumber:self.price];
}

- (void)buy {
  if ([SKPaymentQueue canMakePayments]) {
    [[SKPaymentQueue defaultQueue] addPayment:self.payment];
  }
}

- (SKPayment *)payment {
  return [SKPayment paymentWithProduct:self];
}

@end
