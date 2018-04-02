//
//  YDXAdsNotice.h
//  ydx_push
//
//  Created by maoziyue on 2018/4/2.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *const PUSHNOTICE = @"PUSHNOTICE";

@interface YDXAdsNotice : UIView


+ (instancetype)noticeTitle:(NSString *)title content:(NSString *)content;


/**
 开启向下弹出动画
 */
- (void)animationDrown;



@end
