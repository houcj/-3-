//
//  DisplayController.m
//  定时器3种实现方式
//
//  Created by 侯春娇 on 2019/7/1.
//  Copyright © 2019 houcj. All rights reserved.
//

#import "DisplayController.h"

@interface DisplayController ()

@property (nonatomic) CADisplayLink *display;

@end

#define K_ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define K_ScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation DisplayController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.display) {
        [self.display invalidate];
        self.display = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(30, 150, K_ScreenWidth - 60, 100);
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(30, 300, K_ScreenWidth - 60, 100);
    [endBtn setTitle:@"end" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
}

- (void)start {
    self.display = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayMethod)];
    if (@available(iOS 10.0, *)) {
        self.display.preferredFramesPerSecond = 1;
    } else {
        self.display.frameInterval = 1;
    }
    [self.display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)end {
    [self.display invalidate];
    self.display = nil;
}

- (void)displayMethod {
    static int i = 0;
    NSLog(@"displayMethod --- %d",i);
    i ++;
}

@end
