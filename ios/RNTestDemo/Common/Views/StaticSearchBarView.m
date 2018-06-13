//
//  StaticSearchBarView.m
//  NeoCreation
//
//  Created by admin on 2018/2/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "StaticSearchBarView.h"
#import <Masonry/Masonry.h>

@implementation StaticSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
	
  if(self) {
	[self initViews];
	  
	self.backgroundColor = [UIColor whiteColor];
	self.layer.cornerRadius = 15;
  }
	
  return self;
}

- (void)initViews {
	self.imgvSearchIcon = [UIImageView new];
	self.imgvSearchIcon.image = [UIImage imageNamed:StaticSearchBarViewSearchIconGray];
	[self addSubview:self.imgvSearchIcon];
	
	self.lblSearchKey = [UILabel new];
	self.lblSearchKey.text = @"搜索";
	self.lblSearchKey.textColor = [UIColor blackColor];
	self.lblSearchKey.font = [UIFont systemFontOfSize:13];
	[self addSubview:self.lblSearchKey];
	
	[self setupConstraints];
}

- (void)setupConstraints {
	[self.imgvSearchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.mas_left).with.offset(9);
		make.centerY.equalTo(self.mas_centerY);
	}];
	
	[self.lblSearchKey mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.imgvSearchIcon.mas_right).with.offset(4);
		make.centerY.equalTo(self.mas_centerY);
		make.right.lessThanOrEqualTo(self.mas_right).with.offset(-15);
	}];
}

@end
