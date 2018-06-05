/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>
//#import <React/RCTRootView.h>
#import <XGNavigationController.h>
#import <XGRNBridgeManager.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  NSURL *jsCodeLocation;
//  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                      moduleName:@"RNTestDemo"
//                                               initialProperties:nil
//                                                   launchOptions:launchOptions];
//  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
//  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//  UIViewController *rootViewController = [UIViewController new];
//  rootViewController.view = rootView;
//  self.window.rootViewController = rootViewController;
//  [self.window makeKeyAndVisible];
  
  
  
  // 获取js包的路径
  NSURL *jsCodeLocation;
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  // 配置通用Bridge
  [[XGRNBridgeManager standardManager] loadBridgeWithBundleURL:jsCodeLocation andModuleName:@"RNTestDemo" launchOptions:launchOptions];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.backgroundColor = [UIColor whiteColor];
  self.window.rootViewController = [XGNavigationController createWithLaunchOptions:launchOptions];
  [self.window makeKeyAndVisible];
  
  return YES;
}

@end
