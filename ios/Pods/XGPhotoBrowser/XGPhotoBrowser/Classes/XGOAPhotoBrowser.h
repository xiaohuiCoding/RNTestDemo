//
//  XGOAPhotoBrowser.h
//  XGOA
//
//  Created by 何泽轩 on 2017/4/21.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XGOAPhotoBrowser;

@protocol XGOAPhotoBrowserDelegate <NSObject>

///显示几个图片浏览
- (NSInteger)numberOfImageViewInphotoBrowser:(XGOAPhotoBrowser *)browser;

@optional
///显示本地图片
- (UIImage *)photoBrowser:(XGOAPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
///显示网络图片
- (NSURL *)photoBrowser:(XGOAPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;
///动画起始/结束位置，需要一个相对window的frame, 如果没有实现就到屏幕中间的那个点
- (CGRect)photoBrowser:(XGOAPhotoBrowser *)browser animteGoalFrameWithIndex:(NSInteger)index;

///从super中移附后回调,主要是给JS调的时候及时把临时存储的一些变量清掉
- (void)photoBrowserDidRemoveFromSuperView:(XGOAPhotoBrowser *)browser;
@end

@interface XGOAPhotoBrowser : UIView
///当前显示图片的index
@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, weak) id<XGOAPhotoBrowserDelegate> delegate;

///pageControl的图片
@property (nonatomic, copy) NSString *pageControlCurrentImageName;
@property (nonatomic, copy) NSString *pageControlDefaultImageName;

///显示
- (void)show;

@end
