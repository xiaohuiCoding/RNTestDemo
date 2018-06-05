//
//  XGOABottomActionSheet.m
//  XGOA
//
//  Created by 何泽轩 on 2017/4/19.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#import "XGOABottomActionSheet.h"
#import "XGOAPhotoBrowserConfig.h"

#define CELL_HEIGHT 50.f
#define CELL_SPACE  8.0f
#define CELL_TOP_MARGIN 16.0f;

@interface XGOABottomActionSheet ()

@property (nonatomic, strong) NSArray   *titleArr;

@property (nonatomic, strong) UIView    *btnBgView;

@property (nonatomic,assign,getter=isShow) BOOL  show;

@property (nonatomic, strong) UIButton *selectedButton;

///bottom样式
@property (nonatomic, assign) XGOABottomActionSheetType sheetType;
@end
@implementation XGOABottomActionSheet

- (instancetype)initWithTitleArray:(NSArray *)titleArr sheetType:(XGOABottomActionSheetType)sheetType {
  if (self = [super init]) {
    self.frame = XGPB_KeyWindow.bounds;
    self.titleArr  = titleArr;
    self.sheetType = sheetType;
    self.selectedIndex = -1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self addGestureRecognizer:tap];
  }

  return self;
}

- (UIColor *)textColor {
  if (!_textColor) {
    _textColor = [UIColor colorWithWhite:0x33/255.0 alpha:1];
  }
  return _textColor;
}

- (UIColor *)selectTextColor {
  if (!_selectTextColor) {
    _selectTextColor = [UIColor colorWithRed:0xcc/255 * 1.0 green:0xaa / 255 * 1.0  blue:0x66 / 255 * 1.0 alpha:1];
  }

  return _selectTextColor;
}

///相对iPhoneX的偏移,先写死，后面看有什么好的替换方法
- (CGFloat)iPhoneXBottomMarginHeight {
  BOOL isX = NO;
  if (@available(iOS 11.0, *)) {
    isX = XGPB_KeyWindow.safeAreaInsets.top > 0;
  }

  return isX ? 34 : 0;
}

- (void)setUpUI {
  self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
  // 按钮背景
  CGFloat bgHeight = 0;
  CGFloat topMargin = 0;
  CGFloat buttonMargin = 0;
  CGFloat buttonLeftMargin = 0;
  CGFloat cancleButtonMargin = self.cancleButtonMargin > 0 ?: CELL_SPACE;
  UIColor *textColor = self.textColor;
  UIColor *selectTextColor = self.selectTextColor;
  UIColor *btnBgColor = [UIColor whiteColor];
  //    UIColor *bgColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];
  UIColor *bgColor = [UIColor whiteColor];

  switch (self.sheetType) {
    case XGOABottomActionSheetTypeNormal: {
      bgHeight = CELL_HEIGHT * self.titleArr.count + (CELL_HEIGHT + cancleButtonMargin);
    }
      break;
    case XGOABottomActionSheetTypeNoCancle:
      bgHeight  = CELL_HEIGHT * self.titleArr.count;
      break;
    case XGOABottomActionSheetTypeCustom: {
      selectTextColor = nil;
      bgColor = [UIColor whiteColor];
      topMargin = CELL_TOP_MARGIN;
      buttonMargin = CELL_SPACE;
      bgHeight = CELL_HEIGHT * (self.titleArr.count + 1) + (self.titleArr.count) * buttonMargin + 2 * topMargin;
      if (self.normalButtonBgColor) {
        btnBgColor = self.normalButtonBgColor;
      }
      if (textColor) {
        textColor = self.normalButtonTextColor;
      }
      buttonLeftMargin = topMargin;
    }
      break;
    default:
      break;
  }


  CGSize size = self.bounds.size;
  //iPhoneX 适配
  bgHeight += [self iPhoneXBottomMarginHeight];
  self.btnBgView.frame = CGRectMake(0, size.height, size.width ,bgHeight);
  self.btnBgView.backgroundColor = bgColor;
  [self addSubview:self.btnBgView];

  CGFloat btnW = size.width - 2 * buttonLeftMargin;
  CGFloat btnH = CELL_HEIGHT - 0.5;

  NSInteger index = 0;
  for (NSString *title in self.titleArr) {
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    if (selectTextColor) {
      [btn setTitleColor:selectTextColor forState:UIControlStateSelected];
    }
    [btn setBackgroundColor:btnBgColor];
    btn.tag = index;

    if (index == self.selectedIndex) {
      self.selectedButton = btn;
      btn.selected = YES;
    }else {
      btn.selected = NO;
    }

    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(buttonLeftMargin, topMargin +  index * (CELL_HEIGHT + buttonMargin), btnW, btnH);
    [self.btnBgView addSubview:btn];

    index++;

    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), btn.frame.size.width, 0.5f)];
    seperatorLine.backgroundColor = _seperatorLineColor ?: [UIColor colorWithWhite:0xe5 / 255.0 alpha:1];
    [self.btnBgView  addSubview:seperatorLine];

  }

  if (self.sheetType != XGOABottomActionSheetTypeNoCancle) {
    // 取消
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:self.textColor forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = index;
    btn.frame = CGRectMake(buttonLeftMargin, bgHeight - CELL_HEIGHT -  topMargin - [self iPhoneXBottomMarginHeight], btnW, CELL_HEIGHT);
    if (self.sheetType == XGOABottomActionSheetTypeCustom && self.cancleBorderWidth > 0) {
      btn.layer.borderWidth = self.cancleBorderWidth;
      btn.layer.borderColor = self.cancleBorderColor.CGColor;
    }
    [self.btnBgView addSubview:btn];
  }
}
- (void)showUserHomePage {
  ////遮挡按钮，不让点击,可以不做任何操作
}
- (void)btnClickAction:(UIButton *)btn {
  ///取消按钮
  if (btn.tag >= self.titleArr.count) {
    [self hiddenSheet];
    return;
  }


  [self.selectedButton setSelected:NO];
  [btn  setSelected:YES];
  self.selectedButton = btn;

  if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
    [self.delegate actionSheet:self clickButtonAtIndex:btn.tag];
  }

  if (self.clickIndex) {
    self.clickIndex(btn.tag);
  }

  [self hiddenSheet];
}

- (UIView *)btnBgView{
  if (!_btnBgView) {
    _btnBgView = [[UIView alloc]init];
    _btnBgView.backgroundColor = [UIColor redColor];
  }
  return _btnBgView;
}

#pragma --mark actions
///显示
- (void)show {
  if ([self superview]) {
    return;
  }

  ///如果没有
  if (![self.btnBgView subviews].count) {
    [self setUpUI];
  }

  UIWindow *window = XGPB_KeyWindow;
  [window addSubview:self];
  CGSize size = self.bounds.size;
  // 显示
  [UIView animateWithDuration:0.3 animations:^{
    CGRect frame = self.btnBgView.frame;
    frame.origin.y =  size.height - frame.size.height;
    self.btnBgView.frame = frame;
  }];
}


- (void)hiddenSheet {
  [self hideWithAnimate:YES];
}

- (void)hideWithAnimate:(BOOL)animate {
  if (animate) {
    [UIView animateWithDuration:0.3 animations:^{
      CGRect frame = self.btnBgView.frame;
      frame.origin.y = [UIScreen mainScreen].bounds.size.height;
      self.btnBgView.frame = frame;
    } completion:^(BOOL finished) {
      [self removeFromSuperview];
    }];
  }else {
    [self removeFromSuperview];
  }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

