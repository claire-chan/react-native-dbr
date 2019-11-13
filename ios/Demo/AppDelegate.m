/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>
#import "../../Libraries/BarcodeReaderManagerViewController.h"
#import "../../Libraries/DbrManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  _rootView = [[RCTRootView alloc] initWithBridge:bridge
                                       moduleName:@"Demo"
                                initialProperties:nil];

  _rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  _rootViewController = [UIViewController new];
  _rootViewController.view = _rootView;
//  self.window.rootViewController = rootViewController;
  _nav = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
  self.window.rootViewController = _nav;
  _nav.navigationBarHidden = YES;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNotification:) name:@"readBarcode" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToJs:) name:@"backToJs" object:nil];
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

-(void)doNotification:(NSNotification *)notification{
  BarcodeReaderManagerViewController* dbrMangerController = [[BarcodeReaderManagerViewController alloc] init];
  dbrMangerController.dbrManager = [[DbrManager alloc] initWithLicense:notification.userInfo[@"inputValue"]];
  [self.nav pushViewController:dbrMangerController animated:YES];
}

-(void)backToJs:(NSNotification *)notification{
  [self.nav popToViewController:self.rootViewController animated:YES];
}

-(void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"readBarcode" object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backToJs" object:nil];
}
@end
