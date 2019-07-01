//
//  ViewController.m
//  定时器3种实现方式
//
//  Created by 侯春娇 on 2019/6/28.
//  Copyright © 2019 houcj. All rights reserved.
//

#import "ViewController.h"
#import "TimerController.h"
#import "DisplayController.h"
#import "GCDController.h"

@interface ViewController ()

@property (nonatomic) UIButton *timerBtn;
@property (nonatomic) UIButton *displayBtn;
@property (nonatomic) UIButton *gcdBtn;

@property (nonatomic) NSTimer *timer;

@end

#define K_ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define K_ScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.timerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.timerBtn setTitle:@"timer" forState:UIControlStateNormal];
    [self.timerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.timerBtn addTarget:self action:@selector(timerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timerBtn];
    self.timerBtn.frame = CGRectMake(30, 150, K_ScreenWidth - 60, 100);
    
    self.displayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.displayBtn setTitle:@"display" forState:UIControlStateNormal];
    [self.displayBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.displayBtn addTarget:self action:@selector(displayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displayBtn];
    self.displayBtn.frame = CGRectMake(30, 300, K_ScreenWidth - 60, 100);
    
    self.gcdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.gcdBtn setTitle:@"gcd" forState:UIControlStateNormal];
    [self.gcdBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.gcdBtn addTarget:self action:@selector(gcdBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gcdBtn];
    self.gcdBtn.frame = CGRectMake(30, 450, K_ScreenWidth - 60, 100);
}

- (void)timerBtnClicked {
    TimerController *vc = [[TimerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)displayBtnClicked {
    DisplayController *vc = [[DisplayController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)gcdBtnClicked {
    GCDController *vc = [[GCDController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
