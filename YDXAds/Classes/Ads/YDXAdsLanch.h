//
//  YDXAdsLanch.h
//  ydx_ads
//
//  Created by maoziyue on 2018/3/30.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const PUSHLANCH = @"PUSHLANCH";

@interface YDXAdsLanch : UIView

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, assign) NSInteger showtime;//默认三秒



- (void)show;



@end
