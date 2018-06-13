//
//  BaseViewController.h
//  NeoCreation
//
//  Created by admin on 2018/3/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"

@class EmptyErrorView, LoadingView;
@interface BaseViewController : UIViewController <NavigationViewDelegate>

@property (nonatomic, strong) EmptyErrorView *networkErrorView;
@property (nonatomic, strong) EmptyErrorView *noDataView;
@property (nonatomic, strong) LoadingView *loadingView;

///navigationView
@property (nonatomic, strong) NavigationView *navigationView;

///默认原生界面是有NavigationView的，如果不需要NavigationView的，直接将方法重写返回NO即可
///还有的不用默认navigationView的初始化时可以跳过，目前放着以后完善
- (BOOL)hideNavigationView;

- (void)showNetworkErrorView:(int)code andDesc:(NSString *)desc;
- (void)hideNetworkErrorView;

- (void)showNoDataView;
- (void)hideNoDataView;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
