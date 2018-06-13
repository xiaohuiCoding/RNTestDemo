//
//  MBProgressHUD+Mask.h
//  NeoCreation
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Mask)

+ (instancetype)showMaskAddedTo:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideMaskForView:(UIView *)view animated:(BOOL)animated;

@end
