//
//  XGOAPhotoBrowser.m
//  XGOA
//
//  Created by 何泽轩 on 2017/4/21.
//  Copyright © 2017年 XGHL. All rights reserved.
//

#import "XGOAPhotoBrowser.h"
#import "UIImageView+YYWebImage.h"
#import "XGOABrowserImageView.h"
#import "XGOAPhotoBrowserConfig.h"
#import "XGOABottomActionSheet.h"
#import "XGOAPageView.h"
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
#import <Photos/PHPhotoLibrary.h>
#else
#import <AssetsLibrary/AssetsLibrary.h>
#endif


@interface XGOAPhotoBrowser()<UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
/**
 分页指示器
 */
@property (strong, nonatomic)  XGOAPageView *pageControl;
@end

@implementation XGOAPhotoBrowser {
  BOOL _hasShowedFistView;
  UILabel *_indexLabel;
  UIButton *_saveButton;
  BOOL _willDisappear;
  XGOABottomActionSheet *sheet;
}

#pragma --mark Views
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = XGOAPhotoBrowserBackgrounColor;
  }
  return self;
}

- (void)dealloc {
  NSLog(@"####WDF photoBrowser deallocd!");
  [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}

- (void)didMoveToSuperview {
  [self setupScrollView];
  [self setupToolbars];
}

- (void)setupToolbars {
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  CGFloat width = 200;
  _pageControl = [[XGOAPageView alloc] initWithFrame:CGRectMake((screenSize.width - width)/2, screenSize.height - 32 - 20, width, 20) currentImage:self.pageControlCurrentImageName ? [UIImage imageNamed:self.pageControlCurrentImageName] : nil andDefaultImage:self.pageControlDefaultImageName ?[UIImage imageNamed:self.pageControlDefaultImageName] : nil];

  [self addSubview:self.pageControl];
  self.pageControl.numberOfPages = self.imageCount;
  if (_currentImageIndex) {
    self.pageControl.currentPage = _currentImageIndex;
  }else{
    self.pageControl.currentPage = 0;
  }

  //设置pageSize以设置为准、否则以图片大小为准、图片也没有默认7*7...
  //    _pageControl.pageSize = CGSizeMake(12, 3);
}

- (void)setupScrollView {
  _scrollView = [[UIScrollView alloc] init];
  _scrollView.delegate = self;
  _scrollView.showsHorizontalScrollIndicator = NO;
  _scrollView.showsVerticalScrollIndicator = NO;
  _scrollView.pagingEnabled = YES;
  [self addSubview:_scrollView];

  for (int i = 0; i < self.imageCount; i++) {
    XGOABrowserImageView *imageView = [[XGOABrowserImageView alloc] init];
    imageView.tag = i;
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    // 单击图片
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];

    //长安图片
    UILongPressGestureRecognizer *PressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onLongGes:)];
    // 双击放大图片
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
    doubleTap.numberOfTapsRequired = 2;

    [singleTap requireGestureRecognizerToFail:doubleTap];

    [imageView addGestureRecognizer:singleTap];
    [imageView addGestureRecognizer:PressGesture];
    [imageView addGestureRecognizer:doubleTap];
    [_scrollView addSubview:imageView];
  }

  [self setupImageOfImageViewForIndex:self.currentImageIndex];
}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index {
  XGOABrowserImageView *imageView = _scrollView.subviews[index];
  self.currentImageIndex = index;
  if (imageView.hasLoadedImage) return;
  [self setImageWithImageView:imageView withIndex:index];
  imageView.hasLoadedImage = YES;
}

///设置图片信息
- (void)setImageWithImageView:(XGOABrowserImageView *)imageView withIndex:(NSInteger)index {
  ///placeHoder只是一个占位符
  if ([self highQualityImageURLForIndex:index]) {
    [imageView setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
  } else {
    imageView.image = [self placeholderImageForIndex:index];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect rect = self.bounds;
  rect.size.width += XGOAPhotoBrowserImageViewMargin * 2;

  _scrollView.bounds = rect;
  _scrollView.center = self.center;

  CGFloat y = 0;
  CGFloat w = _scrollView.frame.size.width - XGOAPhotoBrowserImageViewMargin * 2;
  CGFloat h = _scrollView.frame.size.height;



  [_scrollView.subviews enumerateObjectsUsingBlock:^(XGOABrowserImageView *obj, NSUInteger idx, BOOL *stop) {
    CGFloat x = XGOAPhotoBrowserImageViewMargin + idx * (XGOAPhotoBrowserImageViewMargin * 2 + w);
    obj.frame = CGRectMake(x, y, w, h);
  }];

  _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);

  _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);



  if (!_hasShowedFistView) {
    [self showFirstImage];
  }

  _indexLabel.center = CGPointMake(self.bounds.size.width * 0.5, 35);
  _saveButton.frame = CGRectMake(self.bounds.size.width-60, 20, 50, 25);
}

- (void)showFirstImage {
  CGRect rect = CGRectZero;
  if ([self.delegate respondsToSelector:@selector(photoBrowser:animteGoalFrameWithIndex:)]) {
    rect = [self.delegate photoBrowser:self animteGoalFrameWithIndex:self.currentImageIndex];
  }

  ///如果没有动画frame直接改变alpha
  if (CGRectEqualToRect(CGRectZero, rect)) {
    _scrollView.alpha = 0;
    [UIView animateWithDuration:XGOAPhotoBrowserShowImageAnimationDuration animations:^{
      _scrollView.alpha = 1;
    } completion:^(BOOL finished) {
      _hasShowedFistView = YES;
    }];
    return;
  }

  XGOABrowserImageView *tempView = [[XGOABrowserImageView alloc] initWithFrame:rect];
  tempView.contentMode = [_scrollView.subviews[self.currentImageIndex] contentMode];
  [self setImageWithImageView:tempView withIndex:self.currentImageIndex];
  [self addSubview:tempView];

  CGRect targetTemp = [_scrollView.subviews[self.currentImageIndex] bounds];
  _scrollView.hidden = YES;

  [UIView animateWithDuration:XGOAPhotoBrowserShowImageAnimationDuration animations:^{
    tempView.center = self.center;
    tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
  } completion:^(BOOL finished) {
    _hasShowedFistView = YES;
    [tempView removeFromSuperview];
    _scrollView.hidden = NO;
  }];
}

#pragma --mark Actions
- (void)show {
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  self.frame = window.bounds;
  [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
  [window addSubview:self];
}

-(void)onLongGes:(UILongPressGestureRecognizer *)tap {
  ///只要是长按的就直接调起事件，免得要等手指拿开的时候才去响应事件
  if (tap.state == UIGestureRecognizerStateBegan) {
    ///只有等授权后才能操作
    __weak typeof (&*self)weakSelf = self;
    [self checkPhotoLibraryAuthed:^(BOOL isAuthed) {
      __strong typeof (&*weakSelf)strongSelf = weakSelf;
      if (isAuthed) {
        [strongSelf saveImage];
      }else {
        ///简单提示一下，不用alert
        [strongSelf showToastMessage:@"没有访问相册权限，请到设置中打开访问相册权限" duration:3];
      }
    }];
  }
}

- (void)photoClick:(UITapGestureRecognizer *)recognizer {
  _scrollView.hidden = YES;
  _willDisappear = YES;

  XGOABrowserImageView *currentImageView = (XGOABrowserImageView *)recognizer.view;
  NSInteger currentIndex = currentImageView.tag;

  CGRect targetRect = CGRectZero;
  if ([self.delegate respondsToSelector:@selector(photoBrowser:animteGoalFrameWithIndex:)]) {
    targetRect = [self.delegate photoBrowser:self animteGoalFrameWithIndex:currentIndex];
  }

  ///如果目标位置是0，那秒动画到屏幕中间
  if (CGRectEqualToRect(CGRectZero, targetRect)) {
    targetRect = CGRectMake(self.center.x, self.center.y, 0, 0);
  }

  UIImageView *tempView = [[UIImageView alloc] init];
  ///先不设置contentMode看看能不能满足情况
//  tempView.contentMode = sourceView.contentMode;
  tempView.contentMode = UIViewContentModeScaleAspectFill;
  tempView.clipsToBounds = YES;
  tempView.image = currentImageView.image;
  CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;

  // 防止 因imageview的image加载失败 导致 崩溃
  if (!currentImageView.image) {
    h = self.bounds.size.height;
  }

  tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
  tempView.center = self.center;

  [self addSubview:tempView];
  _saveButton.hidden = YES;
  [UIView animateWithDuration:XGOAPhotoBrowserHideImageAnimationDuration animations:^{
    tempView.frame = targetRect;
    self.backgroundColor = [UIColor clearColor];
    _indexLabel.alpha = 0.1;
  } completion:^(BOOL finished) {
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(photoBrowserDidRemoveFromSuperView:)]) {
      [self.delegate photoBrowserDidRemoveFromSuperView:self];
    }
  }];
}

- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer {
  XGOABrowserImageView *imageView = (XGOABrowserImageView *)recognizer.view;
  CGFloat scale;
  if (imageView.isScaled) {
    scale = 1.0;
  } else {
    scale = 2.0;
  }

  XGOABrowserImageView *view = (XGOABrowserImageView *)recognizer.view;

  [view doubleTapToZommWithScale:scale];
}

///保存图片
- (void)saveImage {
  if (sheet) {
    [sheet removeFromSuperview];
  }
  NSArray *array = @[@"保存图片"];
  sheet = [[XGOABottomActionSheet alloc]initWithTitleArray:array sheetType:XGOABottomActionSheetTypeNormal];
  // 2. Block 方式
  __weak __typeof(&*self) weakSelf = self;
  sheet.clickIndex = ^(NSInteger index){
    NSLog(@"Show Index %zi",index);
    __strong __typeof(&*weakSelf) strongSelf = weakSelf;
    switch (index) {
      case 0:{
        int index = strongSelf.scrollView.contentOffset.x / strongSelf.scrollView.bounds.size.width;
        UIImageView *currentImageView = strongSelf.scrollView.subviews[index];
        if (currentImageView.image) {
          ///这里应该判断一下权限，有权限就做保存，没有权限就不做保存
          UIImageWriteToSavedPhotosAlbum(currentImageView.image, strongSelf, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

          UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
          indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
          indicator.center = weakSelf.center;
          strongSelf.indicatorView = indicator;
          [[UIApplication sharedApplication].keyWindow addSubview:indicator];
          [indicator startAnimating];
        }else {
          ////无法获取到图片的时候直接报错
          [strongSelf showToastMessage:XGOAPhotoBrowserSaveImageFailText duration:1];
        }
      }
        break;
      case 1:
        break;
      default:
        break;
    }
  };

  [sheet show];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
  [_indicatorView removeFromSuperview];

  NSString *message = nil;
  if (error) {
    message = XGOAPhotoBrowserSaveImageFailText;
  }   else {
    message = XGOAPhotoBrowserSaveImageSuccessText;
  }
  [self showToastMessage:message duration:1];
}

///检查一下是否有访问相册的权限
- (void)checkPhotoLibraryAuthed:(void(^)(BOOL isAuthed))complete {
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
  PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
  if (author == PHAuthorizationStatusDenied || author ==PHAuthorizationStatusRestricted){
    complete(NO);
  }else if(author == PHAuthorizationStatusNotDetermined) {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      if ([NSThread isMainThread]) {
        complete(status == PHAuthorizationStatusAuthorized);
      }else {
        dispatch_async(dispatch_get_main_queue(), ^{
          complete(status == PHAuthorizationStatusAuthorized);
        });
      }
    }];
  }else {
      complete(YES);
  }
#else
  ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
  if (author == ALAuthorizationStatusDenied || author == ALAuthorizationStatusRestricted) {
    complete(NO);
  }else {
    complete(YES);
  }
#endif
}


#pragma --mark transfer function
- (UIImage *)placeholderImageForIndex:(NSInteger)index {
  if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
    return [self.delegate photoBrowser:self placeholderImageForIndex:index];
  }
  return nil;
}

- (NSURL *)highQualityImageURLForIndex:(NSInteger)index {
  if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
    return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
  }
  return nil;
}

- (void)showToastMessage:(NSString *)messgae duration:(NSTimeInterval)duration {

  UIFont *font = [UIFont boldSystemFontOfSize:15];
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  CGSize size = [messgae boundingRectWithSize:CGSizeMake(screenSize.width - 150, screenSize.height - 300) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;

  UILabel *label = [[UILabel alloc] init];
  label.textColor = [UIColor whiteColor];
  label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
  label.layer.cornerRadius = 5;
  label.clipsToBounds = YES;
  label.bounds = CGRectMake(0, 0, size.width, size.height + 30); //左右给个偏移10， 上下给个偏移15
  label.center = self.center;
  label.textAlignment = NSTextAlignmentCenter;
  label.numberOfLines = 0;
  label.font = font;
  [[UIApplication sharedApplication].keyWindow addSubview:label];
  [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
  label.text = messgae;
  [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:duration];
}

- (NSInteger)imageCount {
  NSInteger imageCount = 0;
  if ([self.delegate respondsToSelector:@selector(numberOfImageViewInphotoBrowser:)]) {
    imageCount = [self.delegate numberOfImageViewInphotoBrowser:self];
  }

  return imageCount ?: 0;
}

#pragma --mark KVO observer frame change
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context {
  if ([keyPath isEqualToString:@"frame"]) {
    self.frame = object.bounds;
    XGOABrowserImageView *currentImageView = _scrollView.subviews[_currentImageIndex];
    if ([currentImageView isKindOfClass:[XGOABrowserImageView class]]) {
      [currentImageView clear];
    }
  }
}

#pragma mark - scrollview代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
  CGFloat scrollViewW = _scrollView.bounds.size.width;
  self.pageControl.currentPage = (self.scrollView.contentOffset.x + scrollViewW * 0.5f) / scrollViewW;

  // 有过缩放的图片在拖动一定距离后清除缩放
  CGFloat margin = 150;
  CGFloat x = scrollView.contentOffset.x;
  if ((x - index * self.bounds.size.width) > margin || (x - index * self.bounds.size.width) < - margin) {
    XGOABrowserImageView *imageView = _scrollView.subviews[index];
    if (imageView.isScaled) {
      [UIView animateWithDuration:0.5 animations:^{
        imageView.transform = CGAffineTransformIdentity;
      } completion:^(BOOL finished) {
        [imageView eliminateScale];
      }];
    }
  }


  if (!_willDisappear) {
    _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1, (long)self.imageCount];
  }
  [self setupImageOfImageViewForIndex:index];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

