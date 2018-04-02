//
//  YDXAdsNotice.m
//  ydx_push
//
//  Created by maoziyue on 2018/4/2.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXAdsNotice.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// 判断是否为iPhone4
#define iPhone4 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
// 判断是否为iPhone5
#define iPhone5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
// 判断是否为iPhone6
#define iPhone6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
// 判断是否为iPhone6 plus
#define iPhone6plus (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define selfWith [UIScreen mainScreen].bounds.size.width
#define selfHeight 64.f
#define spaceToParentView 10



@interface YDXAdsNotice ()<UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    UIWindow *wd;
}

@property (nonatomic, strong) UIView   *backGroundView;
@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, copy  ) NSString *appName;
@property (nonatomic, copy  ) NSString *title;  //标题
@property (nonatomic, copy  ) NSString *context;//内容
@property (nonatomic, copy  ) NSString *time;
@property (nonatomic, copy  ) NSString *botton;

@end

@implementation YDXAdsNotice

+ (instancetype)noticeTitle:(NSString *)title content:(NSString *)content
{
    YDXAdsNotice *notice = [[YDXAdsNotice alloc]initWithTitle:title content:content];
    return notice;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, - selfHeight, selfWith, selfHeight);
        
        self.title = title;
        
        self.context = content;
        
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backGroundView.frame = CGRectMake(0, 0, selfWith, selfHeight);

}


- (void)setup
{
    
    [self addSubview:self.backGroundView];
    
    [self buildUIInView:self.backGroundView title:self.title text:self.context];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipe];
    
    

    UITapGestureRecognizer *tapDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDoubleAction:)];
    tapDouble.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapDouble];
    
}


- (void)tapDoubleAction:(UITapGestureRecognizer *)tapDouble
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PUSHNOTICE object:nil userInfo:nil];
}




/**
 开启向下弹出动画
 */
- (void)animationDrown
{
    wd = [self mainWindow];
    wd.windowLevel = UIWindowLevelAlert;
    [wd addSubview:self];
    
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint center = self.center;
        center.y += selfHeight;
        self.center = center;
    } completion:^(BOOL finished) {
        //延迟执行,避免过早删除
        [self performSelector:@selector(overs) withObject:nil afterDelay:4.f];
    }];
}


/**
 轻扫手势(向上)
 */
- (void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.state == UIGestureRecognizerStateEnded) {
        [self animationUP:0.15f delay:0.f];
    }
}

- (void)overs{
    [self animationUP:0.3f delay:0.2f];
}


/**
 向上收回动画
 @param duration 动画时间
 @param durationDelay 延迟时间
 */
- (void)animationUP:(CGFloat)duration delay:(CGFloat)durationDelay
{
    [UIView animateWithDuration:duration delay:durationDelay options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center = self.center;
        center.y -= selfHeight;
        self.center = center;
    } completion:^(BOOL finished) {
        self->wd.windowLevel = UIWindowLevelNormal;
        [self removeFromSuperview];
    }];
}




- (void)buildUIInView:(UIView *)view title:(NSString *)title text:(NSString *)text
{
    //UI相关参数配置
    CGFloat titleSize = 0.f;
    CGFloat detailSize = 0.f;
    
    if (iPhone4||iPhone5) {
        titleSize = 15;
        detailSize = 11;
    }
    if (iPhone6) {
        titleSize = 17;
        detailSize = 13;
    }
    if (iPhone6plus) {
        titleSize = 17;
        detailSize = 13;
    }
    
    UIImage *appIcon;
    appIcon = [UIImage imageNamed:@"AppIcon60x60"];
    if (!appIcon) {
        appIcon = [UIImage imageNamed:@"AppIcon80x80"];
    }
    NSDictionary *infoDictionary = [[NSBundle bundleForClass:[self class]] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [infoDictionary objectForKey:@"CFBundleName"];
    }
    
    
//    appIcon = nil;
    
    //1系统icon
    UIImageView *iconImgView = [[UIImageView alloc] initWithImage:appIcon];
    [view addSubview:iconImgView];
    
//    iconImgView.backgroundColor = [UIColor redColor];///////
    
    
    
    
    //2 App名
    UILabel *titleText = [[UILabel alloc] init];
    titleText.textColor = [UIColor whiteColor];
    titleText.text = appName;
    titleText.font = [UIFont systemFontOfSize:titleSize];
    [view addSubview:titleText];
    
//    titleText.backgroundColor = [UIColor redColor];
    
    
    //3 now
    UILabel *nowText = [[UILabel alloc] init];
    nowText.font = [UIFont systemFontOfSize:titleSize-2];
    nowText.text = @"现在";
    nowText.textColor = [UIColor whiteColor];
    nowText.textAlignment = NSTextAlignmentRight;
    [view addSubview:nowText];
    
//    nowText.backgroundColor = [UIColor orangeColor];
    
    
    
    
    //4 传入的信息
    UILabel *detailText = [[UILabel alloc] init];
    detailText.text = [NSString stringWithFormat:@"%@\n%@",title ,text];
    detailText.font = [UIFont systemFontOfSize:detailSize];
    detailText.textColor = [UIColor whiteColor];
    detailText.numberOfLines = 2;
    [view addSubview:detailText];

//    detailText.backgroundColor = [UIColor greenColor];
    

    
    //5 下方按钮
//    UIView *bottomView = [[UIView alloc] init];
//    bottomView.backgroundColor = [UIColor lightGrayColor];
//    bottomView.layer.cornerRadius = spaceToParentView/3.f;
//    bottomView.layer.masksToBounds = YES;
//    bottomView.frame = CGRectMake(0, selfHeight-spaceToParentView, spaceToParentView*3, spaceToParentView/2);
//    bottomView.center = CGPointMake(selfWith/2, selfHeight - spaceToParentView/2);
//    [view addSubview:bottomView];
//
//    bottomView.backgroundColor = [UIColor orangeColor];
    
    
    
    
    
    //UI相关frame设置
    iconImgView.frame = CGRectMake(spaceToParentView, spaceToParentView, appIcon.size.width/3, appIcon.size.width/3);
    
    
    
    CGFloat titleTextToIconImageView = spaceToParentView + iconImgView.frame.size.width + spaceToParentView;
    CGFloat titleTextHeight = [self heightForString:titleText andWidth:titleSize];
    CGFloat titleTextWidth  = selfWith - titleTextToIconImageView - spaceToParentView*2;
    titleText.frame    = CGRectMake(titleTextToIconImageView, spaceToParentView, titleTextWidth - 100, titleTextHeight);
    
    
    
    nowText.frame = CGRectMake(CGRectGetMaxX(titleText.frame), spaceToParentView, 100, titleTextHeight);

    
    
    
    CGFloat detailTextHeight = [self heightForString:detailText andWidth:detailSize];
    CGFloat detailTextX = spaceToParentView + titleTextHeight + 0;
    detailText.frame =  CGRectMake(titleTextToIconImageView,detailTextX , titleTextWidth, detailTextHeight);
    

}



/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UILabel *)textView andWidth:(float)width {
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}





/**
 获取window
 */
- (UIWindow*)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}









//*********************************  ******************************************
#pragma mark --lazy
- (UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]init];
        _backGroundView.backgroundColor = [UIColor blackColor];
    }
    return _backGroundView;
}




@end
