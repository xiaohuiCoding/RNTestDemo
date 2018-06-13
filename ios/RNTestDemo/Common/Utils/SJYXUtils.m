//
//  SJYXUtils.m
//  NeoCreation
//
//  Created by xiaohui on 2018/5/10.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SJYXUtils.h"

@implementation SJYXUtils

+ (instancetype)shareInstance {
	static SJYXUtils *_instance = nil;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		_instance = [[self alloc] init];
	});
	
	return _instance;
}

//判断iPhone X
+ (BOOL)deviceIsIPhoneX {
	BOOL b = NO;
	if (@available(iOS 11.0, *)) {
		b = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top > 0;
	}
	
	return b;
}

@end
