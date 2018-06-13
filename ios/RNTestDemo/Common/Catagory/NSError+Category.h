//
//  NSError+Category.h
//  NeoCreation
//
//  Created by wjyx on 2018/5/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Category)

- (BOOL)netNotConnect;
- (NSString *)errorMsg;

@end
