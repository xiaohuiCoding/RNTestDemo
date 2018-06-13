//
//  Constants.h
//  NeoCreation
//
//  Created by admin on 2018/2/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

//系统版本号大小比较
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define firstPageNo 1
#define pageSizeForEveryPage 20

#define minOffsetTrigger 20
#define minGoUpTrigger [UIScreen mainScreen].bounds.size.height - 64

///悬浮按钮高度
#define XGFloatButtonHeight 56

#define color30C17C [UIColor colorFromHexCode:@"#30C17C"]
#define color333333 [UIColor colorFromHexCode:@"#333333"]
#define colorf7f7f7 [UIColor colorFromHexCode:@"#f7f7f7"]
#define color888888 [UIColor colorFromHexCode:@"#888888"]
#define colorCCCCCC [UIColor colorFromHexCode:@"#CCCCCC"]
#define colore5e5e5 [UIColor colorFromHexCode:@"#e5e5e5"]
#define colorFF7752 [UIColor colorFromHexCode:@"#FF7752"]
#define colorFFCC35 [UIColor colorFromHexCode:@"#FFCC35"]
#define colorf5f5f5 [UIColor colorFromHexCode:@"#f5f5f5"]
#define color3D3B38 [UIColor colorFromHexCode:@"#3D3B38"]
#define color000000_10 [UIColor colorFromHexCode:@"#000000" alpha:10.0/100.0]
#define color000000_50 [UIColor colorFromHexCode:@"#000000" alpha:50.0/100.0]
#define colorf9f9f9_80 [UIColor colorFromHexCode:@"#f9f9f9" alpha:80.0/100.0]
#define color333333_90 [UIColor colorFromHexCode:@"#333333" alpha:90.0/100.0]

//iPhone X
#define isIPhoneX  [SJYXUtils deviceIsIPhoneX]

@interface Constants : NSObject

@end
