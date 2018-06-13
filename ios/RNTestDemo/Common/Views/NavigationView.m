//
//  NavigationView.m
//  nageban
//
//  Created by wufeipeng on 5/19/14.
//  Copyright (c) 2014 yibiyi. All rights reserved.
//

#import "NavigationView.h"
#import "Constants.h"
#import "UIColor+Category.h"

@implementation NavigationView

@synthesize titleLabel,leftButton,rightButton,delegate,bottomline;

+(CGFloat)height {
  return SafeAreaTopHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self renderbase];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self renderbase];
        
        self.titleLabel.text = title;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *)title leftButtonBackHidden:(BOOL)hidden
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        if(!hidden)
        {
            [self leftButtonWithImageName:NAVBACKIMGNAMEBLACK];
        }
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        [self leftButtonWithTitle:leftButtonTitle];
        
        [self rightButtonWithTitle:rightButtonTitle];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonTitle:(NSString*)leftButtonTitle rightButtonImageName:(NSString*)rightButtonImageName
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        [self leftButtonWithTitle:leftButtonTitle];
        
        [self rightButtonWithImageName:rightButtonImageName];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *)title leftButtonBackHidden:(BOOL)hidden rightButtonImageName:(NSString *)rightButtonImageName
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        if(!hidden)
        {
            [self leftButtonWithImageName:NAVBACKIMGNAMEBLACK];
        }
        
        [self rightButtonWithImageName:rightButtonImageName];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *)title leftButtonBackHidden:(BOOL)hidden rightButtonTitle:(NSString *)rightButtonTitle
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        if(!hidden)
        {
            [self leftButtonWithImageName:NAVBACKIMGNAMEBLACK];
        }
        
        [self rightButtonWithTitle:rightButtonTitle];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *)title leftButtonImageName:(NSString *)leftButtonImageName rightButtonImageName:(NSString *)rightButtonImageName
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        [self leftButtonWithImageName:leftButtonImageName];
        
        [self rightButtonWithImageName:rightButtonImageName];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Title:(NSString*)title leftButtonImageName:(NSString*)leftButtonImageName rightButtonTitle:(NSString*)rightButtonTitle
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self renderbase];
        
        self.titleLabel.text = title;
        
        [self leftButtonWithImageName:leftButtonImageName];
        
        [self rightButtonWithTitle:rightButtonTitle];
    }
    return self;
}

-(void)changeToHightlightMode
{
//    self.backgroundView.backgroundColor = NAGEBANNAVIGATIONVIEWCOLOR;
//    self.titleLabel.textColor = [UIColor whiteColor];
//    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.leftButton.tintColor = [UIColor whiteColor];
//    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.rightButton.tintColor = [UIColor whiteColor];
//    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
//    {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    }
//    else
//    {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
//    bottomline.hidden = YES;
}

-(void)renderbase
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, self.frame.size.height-44, self.frame.size.width-100, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textColor = color333333;
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.tintColor = NAGEBANNAVIGATIONVIEWCOLOR;
    leftButton.frame = CGRectMake(0, self.frame.size.height-44, 70, 44);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [leftButton setTitleColor:color333333 forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.tintColor = NAGEBANNAVIGATIONVIEWCOLOR;
    rightButton.frame = CGRectMake(self.frame.size.width-70, self.frame.size.height-44, 70, 44);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [rightButton setTitleColor:color333333 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    self.bottomline = [[UIView alloc] init];
    bottomline.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    bottomline.backgroundColor = colore5e5e5;
    [self addSubview:bottomline];
}

-(void)leftButtonWithImageName:(NSString*)imageName
{
    UIImage* img = [UIImage imageNamed:imageName];
    [leftButton setImage:img forState:UIControlStateNormal];
    CGSize imgsize = CGSizeMake(img.size.width, img.size.height);
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake((leftButton.frame.size.height-imgsize.height)/2, MARGINLEFTANDRIGHTWIDTH, (leftButton.frame.size.height-imgsize.height)/2, leftButton.frame.size.width-MARGINLEFTANDRIGHTWIDTH-imgsize.width)];
}

-(void)rightButtonWithImageName:(NSString*)imageName
{
    if ([imageName isEqualToString:@""]) {
        return;
    }
    UIImage* img = [UIImage imageNamed:imageName];
    [rightButton setImage:img forState:UIControlStateNormal];
    CGSize imgsize = CGSizeMake(img.size.width, img.size.height);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake((rightButton.frame.size.height-imgsize.height)/2, rightButton.frame.size.width-MARGINLEFTANDRIGHTWIDTH-imgsize.width, (rightButton.frame.size.height-imgsize.height)/2, MARGINLEFTANDRIGHTWIDTH)];
}

-(void)leftButtonWithTitle:(NSString*)title
{
    [leftButton setTitle:title forState:UIControlStateNormal];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : leftButton.titleLabel.font}];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake((leftButton.frame.size.height-size.height)/2, MARGINLEFTANDRIGHTWIDTH, (leftButton.frame.size.height-size.height)/2, leftButton.frame.size.width-MARGINLEFTANDRIGHTWIDTH-size.width)];
}

-(void)rightButtonWithTitle:(NSString*)title
{
    [rightButton setTitle:title forState:UIControlStateNormal];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : rightButton.titleLabel.font}];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake((rightButton.frame.size.height-size.height)/2, rightButton.frame.size.width-MARGINLEFTANDRIGHTWIDTH-size.width, (rightButton.frame.size.height-size.height)/2, MARGINLEFTANDRIGHTWIDTH)];
}

-(void)changeLeftButtonImageName:(NSString *)newLeftButtonImageName
{
    [self leftButtonWithImageName:newLeftButtonImageName];
}

-(void)changeRightButtonImageName:(NSString *)newRightButtonImageName
{
    [self rightButtonWithImageName:newRightButtonImageName];
}

-(void)leftButtonClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(leftButtonClicked:)])
    {
        [self.delegate leftButtonClicked:sender];
    }
}

-(void)rightButtonClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(rightButtonClicked:)])
    {
        [self.delegate rightButtonClicked:sender];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
