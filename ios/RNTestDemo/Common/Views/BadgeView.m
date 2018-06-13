//
//  BadgeView.m
//  nageban
//
//  Created by yibiyi on 15/4/29.
//  Copyright (c) 2015年 yibiyi. All rights reserved.
//

#import "BadgeView.h"
//#import "CommonMACRO.h"

#define WidthHeight 16.f
#define FontSize 11.f

@interface BadgeView ()

@property(nonatomic,strong) UILabel *ui_lbl;

@end

@implementation BadgeView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.ui_lbl = [[UILabel alloc] init];
        self.ui_lbl.frame = self.bounds;
        self.ui_lbl.font = [UIFont systemFontOfSize:FontSize];
        self.ui_lbl.textColor = [UIColor whiteColor];
        self.ui_lbl.textAlignment = NSTextAlignmentCenter;
        self.ui_lbl.backgroundColor = [UIColor clearColor];
        [self addSubview:self.ui_lbl];
      
        self.hidden = YES;
    }
    return self;
}

-(void)setCount:(NSInteger)count
{
    _count = count;
    if(_count<=0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        self.ui_lbl.text = _count > 99 ? @"99+" : [NSString stringWithFormat:@"%d", _count];
      
        CGFloat width = 0.f;
        if(_count < 10) {
            width = WidthHeight;
        } else {
          CGSize size = [self.ui_lbl.text boundingRectWithSize:CGSizeMake(100, WidthHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.ui_lbl.font} context:nil].size;
          width = size.width+WidthHeight*1/2;
        }
      
        self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - width, self.frame.origin.y, width, WidthHeight);
        self.ui_lbl.frame = self.bounds;
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

