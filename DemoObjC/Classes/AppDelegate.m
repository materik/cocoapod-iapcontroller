//
//  AppDelegate.m
//  Demo
//
//  Created by materik on 03/01/16.
//
//

#import "AppDelegate.h"
#import <IAPController/IAPController.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [[IAPController sharedInstance] fetchProducts];
  [[IAPController sharedInstance].products.firstObject buy];

  return YES;
}

@end
