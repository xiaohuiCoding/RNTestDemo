//
//  NSString+Money.m
//  NeoCreation
//
//  Created by admin on 2018/3/12.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NSString+Money.h"

@implementation NSString (Money)

+ (NSString *)yuanFromFen:(long)fen {
  NSString *fenStr = [NSString stringWithFormat:@"%.2f", fen * 0.01];
  NSInteger toIndex = fenStr.length - 1;
  for (NSInteger i = fenStr.length - 1; i >= 0; i--) {
    unichar character = [fenStr characterAtIndex:i];
    if (character == '.') {
      toIndex = i;
      break;
    } else if (character != '0') {
      toIndex = i+1;
      break;
    }
  }
  return [NSString stringWithFormat:@"￥%@", [fenStr substringToIndex:toIndex]];
}

@end
