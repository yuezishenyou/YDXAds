//
//  YDXAdsLanch.m
//  ydx_ads
//
//  Created by maoziyue on 2018/3/30.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXAdsLanch.h"



@interface YDXAdsLanch ()

@property (nonatomic, strong) UIImageView *adsView;
@property (nonatomic, strong) UIButton *countBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int count;

@end

@implementation YDXAdsLanch


- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    self.adsView.image = [UIImage imageWithContentsOfFile:filePath];
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.showtime = 3;
        
        [self addChildViews];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 60;
    CGFloat btnH = 30;
    CGFloat kscreenWidth = [[UIScreen mainScreen]bounds].size.width;

    self.countBtn.frame = CGRectMake(kscreenWidth - btnW - 24, btnH, btnW, btnH);
    [self.countBtn setTitle:[NSString stringWithFormat:@"跳过%ld",(long)self.showtime] forState:UIControlStateNormal];
    self.countBtn.layer.cornerRadius = 4.f;
    self.adsView.frame = self.frame;
}


- (void)addChildViews
{
    [self addSubview:self.adsView];
    [self addSubview:self.countBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAds)];
    [self.adsView addGestureRecognizer:tap];

}

- (void)show
{
    [self startTimer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)dismiss
{
    [self deleteTimer];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}










//*********************************************************************************
#pragma mark ------------------ method -------------------------

- (void)pushToAds
{
    [self dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:PUSHLANCH object:nil userInfo:nil];
}


- (void)deleteTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)startTimer
{
    _count = (int)self.showtime;
    [self deleteTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(timerAction)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    _count --;
    [self.countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self dismiss];
    }
}











//*********************************************************************************
#pragma mark ------------------ 懒加载 -------------------------
- (UIImageView *)adsView
{
    if (!_adsView) {
        _adsView = [[UIImageView alloc]init];
        _adsView.userInteractionEnabled = YES;
        _adsView.contentMode = UIViewContentModeScaleAspectFill;
        _adsView.clipsToBounds = YES;
    }
    return _adsView;
}

- (UIButton *)countBtn
{
    if (!_countBtn) {
        _countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countBtn;
}






@end
