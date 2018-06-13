//
//  EmptyErrorView.m
//  NeoCreation
//
//  Created by admin on 2018/3/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "EmptyErrorView.h"
#import <Masonry/Masonry.h>
#import "Constants.h"
#import "UIColor+Category.h"

@interface EmptyErrorView ()

@property (nonatomic, strong) UIImageView *imgv;
@property (nonatomic, strong) UIButton *btnRetry;

@end

@implementation EmptyErrorView {
	NSString *_imageName;
	NSString *_title;
	BOOL _showRetryButton;
}

+ (EmptyErrorView *)viewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title {
	EmptyErrorView *emptyErrorView = [[EmptyErrorView alloc] initWithFrame:frame imageName:imageName title:title showRetryButton:NO];
	return emptyErrorView;
}

+ (EmptyErrorView *)viewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title showRetryButton:(BOOL)showRetryButton {
	EmptyErrorView *emptyErrorView = [[EmptyErrorView alloc] initWithFrame:frame imageName:imageName title:title showRetryButton:showRetryButton];
	return emptyErrorView;
}

+ (EmptyErrorView *)networkErrorView {
	EmptyErrorView *emptyErrorView = [[EmptyErrorView alloc] initWithFrame:CGRectZero imageName:@"netFail" title:@"数据获取失败\n请检查网络后点击重新加载" showRetryButton:YES];
	return emptyErrorView;
}

+ (EmptyErrorView *)noDataView {
	EmptyErrorView *emptyErrorView = [[EmptyErrorView alloc] initWithFrame:CGRectZero imageName:@"img_line" title:@"暂无商品" showRetryButton:NO];
	return emptyErrorView;
}

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title showRetryButton:(BOOL)showRetryButton {
	self = [super initWithFrame:frame];
	if (self) {
		
		_imageName = imageName;
		_title = title;
		_showRetryButton = showRetryButton;
		
		[self initViews];
		
		self.clipsToBounds = YES;
		self.backgroundColor = colorf5f5f5;
		
	}
	return self;
}

- (void)initViews {
	self.imgv = [UIImageView new];
	self.imgv.image = [UIImage imageNamed:_imageName];
	[self addSubview:self.imgv];
	
	self.lblTitle = [UILabel new];
	self.lblTitle.numberOfLines = 0;
	self.lblTitle.attributedText = [self attributedTextWithTitle:_title];
	[self addSubview:self.lblTitle];
	
	if (_showRetryButton) {
		self.btnRetry = [UIButton new];
		[self.btnRetry setTitle:@"重新加载" forState:UIControlStateNormal];
		[self.btnRetry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		self.btnRetry.titleLabel.font = [UIFont systemFontOfSize:13.f];
		self.btnRetry.layer.cornerRadius = 4.f;
		self.btnRetry.clipsToBounds = YES;
		[self.btnRetry setBackgroundImage:[UIImage imageNamed:@"rectangle"] forState:UIControlStateNormal];
		[self.btnRetry addTarget:self action:@selector(btnRetryClicked) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.btnRetry];
	}
	
	[self setupConstraints];
}

- (void)setupConstraints {
	[self.imgv mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.mas_centerX);
		make.bottom.equalTo(self.lblTitle.mas_top).with.offset(-15);
	}];
	
	[self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.mas_centerX);
		make.bottom.equalTo(self.mas_centerY);
		make.left.equalTo(self.mas_left).with.offset(40);
		make.right.equalTo(self.mas_right).with.offset(-40);
	}];
	
	if (_showRetryButton) {
		[self.btnRetry mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(self.mas_centerX);
			make.top.equalTo(self.lblTitle.mas_bottom).with.offset(20);
			make.width.mas_equalTo(120);
			make.height.mas_equalTo(40);
		}];
	}
}

- (NSAttributedString *)attributedTextWithTitle:(NSString *)title {
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.minimumLineHeight = 20;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSDictionary *defaults = @{
							   NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
							   NSForegroundColorAttributeName : color888888,
							   NSParagraphStyleAttributeName : paragraphStyle
							   };
	return [[NSAttributedString alloc] initWithString:_title attributes:defaults];
}

- (void)btnRetryClicked {
	if(self.delegate && [self.delegate respondsToSelector:@selector(emptyErrorViewRetryClicked:)]) {
		[self.delegate emptyErrorViewRetryClicked:self];
	}
}

@end

