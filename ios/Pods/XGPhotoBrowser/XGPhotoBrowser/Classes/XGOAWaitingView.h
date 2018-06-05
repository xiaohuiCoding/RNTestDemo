//
//  XGOAWaitingView.h
//  XGOA
//
//  Created by 何泽轩 on 2017/4/21.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGOAPhotoBrowserConfig.h"

typedef NS_ENUM(NSInteger, XGOAWaitingViewMode) {
  XGOAWaitingViewModeLoopDiagram, // 环形
  XGOAWaitingViewModePieDiagram // 饼型
};

@interface XGOAWaitingView : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) XGOAWaitingViewMode waitMode;
@end
