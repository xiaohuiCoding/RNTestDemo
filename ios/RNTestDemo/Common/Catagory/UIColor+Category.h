//
//  UIColor+Category.h
//  HMSegmentedControlExample
//
//  Created by admin on 2018/2/23.
//  Copyright © 2018年 HeshamMegid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor *)colorFromHexCode:(NSString *)hexString;
+ (UIColor *)colorFromHexCode:(NSString *)hexString alpha:(float)alpha;

@end
