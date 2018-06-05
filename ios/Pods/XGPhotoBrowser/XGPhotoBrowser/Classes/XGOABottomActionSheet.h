//
//  XGOABottomActionSheet.h
//  XGOA
//
//  Created by 何泽轩 on 2017/4/19.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickWithIndexBlock)(NSInteger index);

typedef NS_ENUM(NSUInteger, XGOABottomActionSheetType) {
    XGOABottomActionSheetTypeNormal = 0, //默认样式
    XGOABottomActionSheetTypeNoCancle,   ///没有cancle按钮
    XGOABottomActionSheetTypeCustom,      ///自定义，要求传入默认背景色，取消按钮背景色
};

@class XGOABottomActionSheet;
@protocol XGOAActionSheetDelegate <NSObject>

- (void)actionSheet:(XGOABottomActionSheet *)actionSheet clickButtonAtIndex:(NSInteger )buttonIndex;

@end
@interface XGOABottomActionSheet : UIView
// 支持代理
@property (nonatomic, weak) id <XGOAActionSheetDelegate> delegate;

// 支持block
@property (nonatomic, copy) ClickWithIndexBlock clickIndex;

///默认中8，如果要设置更高的就设置这属性
@property (nonatomic, assign)  CGFloat cancleButtonMargin;

///selected index
@property (nonatomic, assign) NSInteger selectedIndex;

///custom property
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectTextColor;
@property (nonatomic, strong) UIColor *seperatorLineColor;
///按钮
@property (nonatomic, strong) UIColor *normalButtonBgColor;
@property (nonatomic, strong) UIColor *normalButtonTextColor;
@property (nonatomic, strong) UIColor *cancleBorderColor;
@property (nonatomic, assign) CGFloat cancleBorderWidth;

- (instancetype)init NS_UNAVAILABLE;
/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr sheetType:(XGOABottomActionSheetType)sheetType;

///显示
- (void)show;

///隐藏
- (void)hideWithAnimate:(BOOL)animate;
@end
