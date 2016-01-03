//
//  IAPController.m
//  Pods
//
//  Created by materik on 03/01/16.
//
//

#import "IAPController.h"

NSString *const IAPControllerFetchedNotification =
    @"IAPControllerFetchedNotification";
NSString *const IAPControllerPurchasedNotification =
    @"IAPControllerPurchasedNotification";
NSString *const IAPControllerFailedNotification =
    @"IAPControllerFailedNotification";
NSString *const IAPControllerRestoredNotification =
    @"IAPControllerRestoredNotification";

static IAPController *_sharedInstance;

@interface IAPController () <SKProductsRequestDelegate,
                             SKPaymentTransactionObserver>

@property(nonatomic, strong) NSArray<NSString *> *productIds;

@end

@implementation IAPController

@synthesize products = _products;

+ (IAPController *)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[IAPController alloc] init];
  });
  return _sharedInstance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [self retrieveProductIdsFromPlist];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
  }
  return self;
}

- (void)retrieveProductIdsFromPlist {
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"IAPControllerProductIds"
                                       withExtension:@"plist"];
  self.productIds = [NSArray arrayWithContentsOfURL:url];
}

#pragma mark - Action

- (void)fetchProducts {
  SKProductsRequest *request = [[SKProductsRequest alloc]
      initWithProductIdentifiers:[NSSet setWithObjects:self.productIds, nil]];
  [request setDelegate:self];
  [request start];
}

- (void)restore {
  [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - SKPaymentTransactionObserver

- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response {
  _products = response.products;
  [[NSNotificationCenter defaultCenter]
      postNotificationName:IAPControllerFetchedNotification
                    object:nil];
}

- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
  for (SKPaymentTransaction *transaction in transactions) {
    switch (transaction.transactionState) {
    case SKPaymentTransactionStatePurchased:
      [self purchasedTransaction:transaction];
      break;
    case SKPaymentTransactionStateFailed:
      [self failedTransaction:transaction error:nil];
      break;
    case SKPaymentTransactionStateRestored:
      [self restoreTransaction:transaction];
      break;
    default:
      break;
    }
  }
}

- (void)paymentQueue:(SKPaymentQueue *)queue
    restoreCompletedTransactionsFailedWithError:(NSError *)error {
  [self failedTransaction:nil error:error];
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:
    (SKPaymentQueue *)queue {
  [[NSNotificationCenter defaultCenter]
      postNotificationName:IAPControllerRestoredNotification
                    object:nil];
}

#pragma mark - Transactions

- (void)finishTransaction:(SKPaymentTransaction *)transaction {
  if (transaction) {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
  }
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
  [self finishTransaction:transaction];
  [[NSNotificationCenter defaultCenter]
      postNotificationName:IAPControllerPurchasedNotification
                    object:nil];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
                    error:(NSError *)error {
  [self finishTransaction:transaction];
  error = error ?: transaction.error;
  if (error) {
    if (error.code != SKErrorPaymentCancelled) {
      [[NSNotificationCenter defaultCenter]
          postNotificationName:IAPControllerFailedNotification
                        object:error];
    }
  }
}

- (void)purchasedTransaction:(SKPaymentTransaction *)transaction {
  [self finishTransaction:transaction];
  [[NSNotificationCenter defaultCenter]
      postNotificationName:IAPControllerPurchasedNotification
                    object:nil];
}

@end
