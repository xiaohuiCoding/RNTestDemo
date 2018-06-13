//
//  NavigationView.h
//  nageban
//
//  Created by wufeipeng on 5/19/14.
//  Copyright (c) 2014 yibiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationViewDelegate <NSObject>

@optional
-(void)leftButtonClicked:(id)sender;
-(void)rightButtonClicked:(id)sender;

@end

#define kWJScreenHeight UIScreen.mainScreen.bounds.size.height
#define SafeAreaTopHeight (kWJScreenHeight == 812.0 ? 88 : 64)

#define MARGINLEFTANDRIGHTWIDTH 16.f

#define NAVBACKIMGNAMEBLACK @"btn_back_black"
#define NAVBACKIMGNAMEWHITE @"btn_back_white"

@interface NavigationView : UIView

+(CGFloat)height;

@property(nonatomic,weak) id<NavigationViewDelegate> delegate;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIButton* leftButton;
@property(nonatomic,strong) UIButton* rightButton;
@property(nonatomic,strong) UIView* backgroundView;
@property(nonatomic,strong) UIView* bottomline;

- (id)initWithFrame:(CGRect)frame Title:(NSString*)title;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonBackHidden:(BOOL)hidden;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonTitle:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonTitle:(NSString*)leftButtonTitle rightButtonImageName:(NSString*)rightButtonImageName;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonBackHidden:(BOOL)hidden rightButtonImageName:(NSString*)rightButtonImageName;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonBackHidden:(BOOL)hidden rightButtonTitle:(NSString*)rightButtonTitle;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonImageName:(NSString*)leftButtonImageName rightButtonImageName:(NSString*)rightButtonImageName;

- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonImageName:(NSString*)leftButtonImageName rightButtonTitle:(NSString*)rightButtonTitle;

-(void)changeLeftButtonImageName:(NSString*)newLeftButtonImageName;
-(void)changeRightButtonImageName:(NSString*)newRightButtonImageName;
-(void)changeToHightlightMode;

@end
