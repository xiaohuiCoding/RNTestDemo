//
//  StaticSearchBarView.h
//  NeoCreation
//
//  Created by admin on 2018/2/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#define StaticSearchBarViewSearchIconDarkGray @"icon_search_darkgray"
#define StaticSearchBarViewSearchIconGray @"icon_search_gray"
#define StaticSearchBarViewSearchIconWhite @"icon_search_white"

@interface StaticSearchBarView : UIButton

@property(nonatomic, strong) UIImageView *imgvSearchIcon;
@property(nonatomic, strong) UILabel *lblSearchKey;

@end
