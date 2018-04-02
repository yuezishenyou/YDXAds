//
//  YDXAdsAlert.m
//  ydx_ads
//
//  Created by maoziyue on 2018/3/30.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXAdsAlert.h"



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// 判断是否为iPhone5
#define iPhone5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
// 判断是否为iPhone6
#define iPhone6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
// 判断是否为iPhone6 plus
#define iPhone6plus (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


@interface YDXAdsAlert ()

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView   *mainView;

@end

@implementation YDXAdsAlert

- (instancetype)init
{
    if (self = [super init]) {
        
        self.frame = [[UIScreen mainScreen]bounds];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addChildViews];
        
    }
    return self;
}



- (void)addChildViews
{

    [self addSubview:self.bgBtn];
    
    [self addSubview:self.mainView];
    
    [self addSubview:self.cancelBtn];
    
    self.cancelBtn.backgroundColor = [UIColor redColor];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
 
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
  
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat selfHeight = self.bounds.size.height;
    
    self.bgBtn.frame = self.bounds;
    
    self.mainView.frame = CGRectMake(0, 0, 260, 360);
    self.mainView.center = CGPointMake(selfWidth / 2, selfHeight / 2);
    
   
    
    self.cancelBtn.frame = CGRectMake(0, 0, 30, 30);
    self.cancelBtn.center = CGPointMake(selfWidth / 2, CGRectGetMaxY(self.mainView.frame) + 80);
 
    
   
}




- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.bgBtn.alpha = 0.3;
    
    [UIView animateWithDuration:0.3f animations:^{

    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    self.bgBtn.alpha = 0.0;
    [UIView animateWithDuration:0.3f animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

- (void)bgBtnAction
{
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PUSHALERT object:nil userInfo:nil];
}












#pragma mark -----------------------------------------
- (UIButton *)bgBtn
{
    if (!_bgBtn) {
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _bgBtn.backgroundColor = [UIColor blackColor];
    }
    return _bgBtn;
}

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}








@end
