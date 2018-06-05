//
//  XGOAPageView.m
//  retail
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XGOAPageView.h"
@interface XGOAPageView()
@property (nonatomic) CGSize size;

@end
@implementation XGOAPageView
-(instancetype)initWithFrame:(CGRect)frame currentImage:(UIImage *)currentImage andDefaultImage:(UIImage *)defaultImage {
  //pag不可点击
  self.userInteractionEnabled = NO;
  self = [super initWithFrame:frame];
  self.currentImage = currentImage;
  self.defaultImage = defaultImage;
  return self;
}

-(instancetype) init {
  self = [super init];
  return self;
}

-(void) setUpDots {

  //默认的大小，如果有图片会以图片的大小来显示
  self.size = CGSizeMake(12, 3);
  if (self.pageSize.height && self.pageSize.width) {
    self.size = self.pageSize;
  }

  for (int i=0; i<[self.subviews count]; i++) {

    UIView* dot = [self.subviews objectAtIndex:i];

    [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, self.size.width, self.size.height)];
    if ([dot.subviews count] == 0) {
      UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
      [dot addSubview:view];
    };
    UIImageView * view = dot.subviews[0];

    ///不设置的时候用默认的，不改变原生的东西才会用默认的，要不然就是空
    if (i==self.currentPage) {
      if (self.currentImage) {
        view.image=self.currentImage;
        dot.backgroundColor = [UIColor clearColor];
      }else {
//        view.image = nil;
//        dot.backgroundColor = self.currentPageIndicatorTintColor;
      }
    }else if (self.defaultImage) {
      view.image=self.defaultImage;
      dot.backgroundColor = [UIColor clearColor];
    }else {
//      view.image = nil;
//      dot.backgroundColor = self.pageIndicatorTintColor;
    }
  }
}


-(void) setCurrentPage:(NSInteger)page

{

  [super setCurrentPage:page];

  [self setUpDots];

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


