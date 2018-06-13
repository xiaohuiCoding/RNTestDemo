//
//  BaseViewController.m
//  NeoCreation
//
//  Created by admin on 2018/3/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "BaseViewController.h"
#import "EmptyErrorView.h"
#import "LoadingView.h"

@interface BaseViewController ()<EmptyErrorViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setupNavigationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark NavigationView
- (BOOL)hideNavigationView {
	return NO;
}

- (void)setTitle:(NSString *)title {
	[super setTitle:title];
	self.navigationView.titleLabel.text = title;
}

- (void)setupNavigationView {
	///界面不需要nav的时候直接不初始化，如果nav有，只是处于隐藏状态请不到返回YES
	if ([self hideNavigationView]) {
		return;
	}

	BOOL showBack = self.navigationController.viewControllers.count > 1;
	self.navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [NavigationView height]) Title:nil leftButtonBackHidden:!showBack];
	self.navigationView.delegate = self;
	[self.view addSubview:self.navigationView];
	self.navigationView.backgroundColor = [UIColor cyanColor];
}

#pragma mark -- NavigationViewDelegate
-(void)leftButtonClicked:(id)sender {
	if (self.navigationController && self.navigationController.viewControllers.count > 1) {
		[self.navigationController popViewControllerAnimated:YES];
	}else {
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}
-(void)rightButtonClicked:(id)sender {

}

#pragma mark - NetworkErrorView

- (void)showNetworkErrorView:(int)code andDesc:(NSString *)desc{
  if (!self.networkErrorView) {
    self.networkErrorView = [EmptyErrorView networkErrorView];
    self.networkErrorView.delegate = self;
    [self.view addSubview:self.networkErrorView];
  }
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.minimumLineHeight = 20;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSDictionary *defaults = @{
							   NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
							   NSForegroundColorAttributeName : color888888,
							   NSParagraphStyleAttributeName : paragraphStyle
							   };
	NSString * msg = @"数据获取失败\n请检查网络后点击重新加载";
	if (desc && code) {
		msg = [NSString stringWithFormat:@"%d %@",code,desc];
	} else if(desc){
		msg = desc;
	}
	NSAttributedString *muAttrString = [[NSAttributedString alloc] initWithString:msg attributes:defaults];
	self.networkErrorView.lblTitle.attributedText = muAttrString;
  self.networkErrorView.frame = [self emptyErrorViewFrame:self.networkErrorView];
  [self.view bringSubviewToFront:self.networkErrorView];
  self.networkErrorView.hidden = NO;
}

- (void)hideNetworkErrorView {
  self.networkErrorView.hidden = YES;
}

#pragma mark - NoDataView

- (void)showNoDataView {
  if (!self.noDataView) {
    self.noDataView = [EmptyErrorView noDataView];
    self.noDataView.delegate = self;
    [self.view addSubview:self.noDataView];
  }
  
  self.noDataView.frame = [self emptyErrorViewFrame:self.noDataView];
  [self.view bringSubviewToFront:self.noDataView];
  self.noDataView.hidden = NO;
}

- (void)hideNoDataView {
  self.noDataView.hidden = YES;
}

#pragma mark - LoadingView

- (void)showLoadingView {
  if (!self.loadingView) {
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.loadingView];
  }
  
  self.loadingView.frame = [self loadingViewFrame];
  [self.view bringSubviewToFront:self.loadingView];
  self.loadingView.hidden = NO;
}

- (void)hideLoadingView {
  self.loadingView.hidden = YES;
}

#pragma mark - EmptyErrorViewDelegate<NSObject>

- (CGRect)loadingViewFrame {
  return self.view.bounds;
}

- (CGRect)emptyErrorViewFrame:(EmptyErrorView *)emptyErrorView {
	if (!emptyErrorView) {
		return CGRectZero;
	}
  return self.view.bounds;
}

- (void)emptyErrorViewRetryClicked:(EmptyErrorView *)emptyErrorView {
	if (!emptyErrorView) {
		return;
	}
}

@end
