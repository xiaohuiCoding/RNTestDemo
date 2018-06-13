//
//  MBProgressHUD+Mask.m
//  NeoCreation
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "MBProgressHUD+Mask.h"

@implementation MBProgressHUD (Mask)

+ (instancetype)showMaskAddedTo:(UIView *)view animated:(BOOL)animated {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
  hud.contentColor = [UIColor whiteColor];
  hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.f];
  hud.mode = MBProgressHUDModeIndeterminate;
  hud.detailsLabel.text = @"加载中...";
  return hud;
}

+ (BOOL)hideMaskForView:(UIView *)view animated:(BOOL)animated {
  return [MBProgressHUD hideHUDForView:view animated:animated];
}

@end
