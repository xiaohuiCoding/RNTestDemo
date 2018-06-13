//
//  XGOAPhotoBrowserConfig.h
//  XGOA
//
//  Created by 何泽轩 on 2017/4/21.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#ifndef XGOAPhotoBrowserConfig_h
#define XGOAPhotoBrowserConfig_h

///以防跟其它定义的宏冲突，加个前缀
#define XGPB_KeyWindow [UIApplication sharedApplication].keyWindow

///============下面的可以改成可以配置的参数形式====================

// 图片保存成功提示文字
#define XGOAPhotoBrowserSaveImageSuccessText @"保存成功 "

// 图片保存失败提示文字
#define XGOAPhotoBrowserSaveImageFailText @"保存失败 "

// browser背景颜色
#define XGOAPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

// browser中图片间的margin
#define XGOAPhotoBrowserImageViewMargin 10

// browser中显示图片动画时长
#define XGOAPhotoBrowserShowImageAnimationDuration 0.4f

// browser中显示图片动画时长
#define XGOAPhotoBrowserHideImageAnimationDuration 0.4f

// 图片下载进度指示进度显示样式（SDWaitingViewModeLoopDiagram 环形，SDWaitingViewModePieDiagram 饼型）
#define XGOAWaitingViewProgressMode XGOAWaitingViewModeLoopDiagram

// 图片下载进度指示器背景色
#define XGOAWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

// 图片下载进度指示器内部控件间的间距
#define XGOAWaitingViewItemMargin 10

#endif /* XGOAPhotoBrowserConfig_h */
