//
//  YDXViewController.m
//  YDXAds
//
//  Created by yuezishenyou on 04/02/2018.
//  Copyright (c) 2018 yuezishenyou. All rights reserved.
//

#import "YDXViewController.h"
#import "YDXADS.h"

@interface YDXViewController ()

@end

@implementation YDXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    YDXAdsNotice *notice = [YDXAdsNotice noticeTitle:@"标题" content:@"内容"];
    
    [notice animationDrown];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
