//
//  TestListViewController.m
//  RNTestDemo
//
//  Created by xiaohui on 2018/4/19.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "TestListViewController.h"
#import "UINavigationController+XGRoute.h"
#import "TestListDetailViewController.h"
#import "XGOAPhotoBrowser.h"

@interface TestListViewController ()<XGOAPhotoBrowserDelegate>
  
@property (nonatomic, copy) NSArray *picArray;
  
@end

@implementation TestListViewController

//- (void)viewWillAppear:(BOOL)animated {
//  [super viewWillAppear:animated];
//  [self.navigationController setNavigationBarHidden:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//  [super viewWillDisappear:animated];
//  [self.navigationController setNavigationBarHidden:YES];
//}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //  UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_header_back"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
  //  self.navigationItem.leftBarButtonItem = leftBarButtonItem;
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationView.titleLabel.text = self.titleString;
  
  
  UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame=CGRectMake(100, 164, 100, 50);
  [button setTitle:@"native->js" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(pushToJS) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  
  UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
  button2.frame=CGRectMake(100, 264, 100, 50);
  [button2 setTitle:@"native->native" forState:UIControlStateNormal];
  [button2 addTarget:self action:@selector(pushToNative) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button2];
  
  UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
  button3.frame=CGRectMake(100, 364, 200, 50);
  [button3 setTitle:@"native->call native photo browser" forState:UIControlStateNormal];
  [button3 addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button3];
  
  
  self.picArray = @[@"http://g.hiphotos.baidu.com/image/pic/item/cf1b9d16fdfaaf519d4aa2db805494eef01f7a2c.jpg",
                    @"http://c.hiphotos.baidu.com/image/pic/item/b21c8701a18b87d65d3311770b0828381f30fd61.jpg",
                    @"http://d.hiphotos.baidu.com/image/pic/item/bd3eb13533fa828b7d666185f11f4134970a5a0b.jpg",
                    @"http://g.hiphotos.baidu.com/image/pic/item/1e30e924b899a9011a42d55e11950a7b0208f567.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/a71ea8d3fd1f41344002e11a291f95cad1c85e99.jpg"
                    ];
}
  
- (void)pushToJS {
  [self.navigationController xg_pushJSPage:@"mine/MinePage"
                                 andParams:@{@"leftBarButtonItemHidden":@(NO)}
                               andAnimated:YES];
}
  
- (void)pushToNative {
    TestListDetailViewController *vc = [[TestListDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showImage {
  XGOAPhotoBrowser *browser = [[XGOAPhotoBrowser alloc] init];
  browser.currentImageIndex = 0;
  browser.delegate = self;
  [browser show];
}

- (void)pop {
  [self.navigationController popViewControllerAnimated:YES];
}
  
#pragma mark - XGOAPhotoBrowserDelegate
  
- (NSInteger)numberOfImageViewInphotoBrowser:(XGOAPhotoBrowser *)browser {
  return self.picArray.count;
}
  
- (NSURL *)photoBrowser:(XGOAPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
  NSString *imageStr = self.picArray[index];
  NSURL *url;
  if([self isUrlString:imageStr]) {
    url = [NSURL URLWithString:imageStr];
  }else {
    url = [[NSBundle mainBundle] URLForResource:imageStr withExtension:nil];
  }
  return url;
}
  
- (UIImage *)photoBrowser:(XGOAPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
  return nil;
}
  
- (BOOL)isUrlString:(NSString *)str {
  //判断是否是网络图片
  if([[str lowercaseString] containsString:@"http:"] || [[str lowercaseString] containsString:@"https:" ]) {
    return YES;
  }else {
    return NO;
  }
}
  
@end
