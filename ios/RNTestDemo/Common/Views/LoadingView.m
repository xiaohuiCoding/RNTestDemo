//
//  LoadingView.m
//  NeoCreation
//
//  Created by admin on 2018/3/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LoadingView.h"
#import "Constants.h"
#import "UIColor+Category.h"
#import <Masonry/Masonry.h>

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
	
  if (self) {
	[self initViews];
	  
	self.clipsToBounds = YES;
	self.backgroundColor = colorf5f5f5;
  }
	
  return self;
}

- (void)initViews {
	UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[activityIndicatorView startAnimating];
	[self addSubview:activityIndicatorView];
	
	[activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
	}];
}

@end
