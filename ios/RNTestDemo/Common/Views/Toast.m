//
//  Toast.m
//  NeoCreation
//
//  Created by admin on 2018/3/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "Toast.h"
#import <MBProgressHUD.h>

@implementation Toast

+ (void)showMsg:(NSString *)msg {
  UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  hud.contentColor = [UIColor whiteColor];
  hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.f];
  hud.mode = MBProgressHUDModeText;
  hud.detailsLabel.text = msg;
  [hud hideAnimated:YES afterDelay:1.f];
}

@end
