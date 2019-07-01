//
//  TimerController.m
//  定时器3种实现方式
//
//  Created by 侯春娇 on 2019/7/1.
//  Copyright © 2019 houcj. All rights reserved.
//

#import "TimerController.h"

@interface TimerController ()

@property (nonatomic) UIButton *begainBtn;
@property (nonatomic) UIButton *stopBtn;
// 需要手动释放
@property (nonatomic) NSTimer *timer;

@end

#define K_ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define K_ScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation TimerController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    self.begainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.begainBtn.frame = CGRectMake(30, 150, K_ScreenWidth - 60, 100);
    [self.begainBtn setTitle:@"begain" forState:UIControlStateNormal];
    [self.begainBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.begainBtn addTarget:self action:@selector(begainBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.begainBtn];
    
    self.stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stopBtn.frame = CGRectMake(30, 300, K_ScreenWidth - 60, 100);
    [self.stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    [self.stopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.stopBtn addTarget:self action:@selector(stopBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stopBtn];
}

- (void)begainBtnClicked {
    // 以前，都是使用这个方法，但是没有办法从RunLoop移除呀，所以，不推荐
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(startTimer1) userInfo:nil repeats:YES];
    // 此方法需要手动加入RunLoop
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(startTimer2) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopBtnClicked {
    // 从RunLoop移除
    [self.timer invalidate];
    // 释放对象
    self.timer = nil;
}

- (void)startTimer1 {
    static int i = 0;
    NSLog(@"startTimer1 === %d",i);
    i ++;
}
- (void)startTimer2 {
    static int j = 0;
    NSLog(@"startTimer2 --- %d",j);
    j ++;
}

@end
