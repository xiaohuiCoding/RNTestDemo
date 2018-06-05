//
//  XGOABrowserImageView.h
//  XGOA
//
//  Created by 何泽轩 on 2017/4/21.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XGOABrowserImageView : UIImageView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;

/// 清除缩放
- (void)eliminateScale;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

///双击放大
- (void)doubleTapToZommWithScale:(CGFloat)scale;

- (void)clear;

@end
