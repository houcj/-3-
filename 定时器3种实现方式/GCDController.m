//
//  GCDController.m
//  定时器3种实现方式
//
//  Created by 侯春娇 on 2019/7/1.
//  Copyright © 2019 houcj. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()

@property (nonatomic) int time;
@property (nonatomic) UIButton *codeBtn;
@property (nonatomic) dispatch_source_t timer;

@end

#define K_ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define K_ScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation GCDController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    UIButton *onceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    onceBtn.frame = CGRectMake(30, 150, K_ScreenWidth - 60, 100);
    [onceBtn setTitle:@"延时调用" forState:UIControlStateNormal];
    [onceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [onceBtn addTarget:self action:@selector(onceBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onceBtn];
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeBtn.frame = CGRectMake(30, 300, K_ScreenWidth - 60, 100);
    [self.codeBtn setTitle:@"发送短信" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(codeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeBtn];
}

- (void)onceBtnClicked {
    double delayInSeconds = 2.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self onceGCD];
    });
}
- (void)codeBtnClicked {
    if (self.time > 0) {
        return;
    }
    self.time = 60;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"%d",self.time);
        if (self.time <= 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 在主线程中做的操作
                [self.codeBtn setTitle:@"重发" forState:UIControlStateNormal];
                self.codeBtn.enabled = YES;
            });
            dispatch_source_cancel(self.timer);
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"倒计时%d",self.time] forState:UIControlStateNormal];
                self.codeBtn.enabled = NO;
            });
            self.time -- ;
        }
        
    });
    dispatch_resume(self.timer);
}

- (void)onceGCD {
    NSLog(@"延时调用");
}

@end
