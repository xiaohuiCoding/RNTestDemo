//
//  EmptyErrorView.h
//  NeoCreation
//
//  Created by admin on 2018/3/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EmptyErrorView;

@protocol EmptyErrorViewDelegate<NSObject>

@optional

- (CGRect)emptyErrorViewFrame:(EmptyErrorView *)emptyErrorView;

- (void)emptyErrorViewRetryClicked:(EmptyErrorView *)emptyErrorView;

@end

@interface EmptyErrorView : UIView

@property (nonatomic, strong) UILabel *lblTitle;

+ (EmptyErrorView *)networkErrorView;
+ (EmptyErrorView *)noDataView;

+ (EmptyErrorView *)viewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title;
+ (EmptyErrorView *)viewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title showRetryButton:(BOOL)showRetryButton;

@property(nonatomic ,weak) id<EmptyErrorViewDelegate> delegate;

@end
