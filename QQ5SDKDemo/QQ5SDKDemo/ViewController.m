//
//  ViewController.m
//  QQ5SDKDemo
//
//  Created by 魅游 on 2017/7/20.
//  Copyright © 2017年 meiyx. All rights reserved.
//

#import "ViewController.h"

#import "QQ5SDK.h"


@interface ViewController ()
@property (nonatomic, strong) UIButton *enterGame;
@property (nonatomic, strong) UIButton *autoLoginBtn;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, assign) BOOL isLanch;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    //appkey 内网 111
    //appkey 现网 H0ndi0tBTq
    //在QQ5游戏中心申请的appId
    //在QQ5游戏中心申请的appKey
    [[QQ5SDK shareInstance] initSDKWithAppId:@"1" WithAppKey:@"H0ndi0tBTq" gameChannel:@"1_1" loginCallBack:^(id data) {
        
        self.enterGame.enabled = YES;
    }];
    
    UIButton *autoLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    autoLoginBtn.frame = CGRectMake(50, 50, 80, 50);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isAutoLogin"] == nil) {
        
        autoLoginBtn.selected = YES;
    }else{
        
        autoLoginBtn.selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isAutoLogin"] boolValue];
    }
    [autoLoginBtn setTitle:@"不自动登录" forState:UIControlStateNormal];
    [autoLoginBtn setTitle:@"自动登录" forState:UIControlStateSelected];
    autoLoginBtn.tag = 3;
    self.autoLoginBtn = autoLoginBtn;
    [autoLoginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoLoginBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(50, 100, 80, 50);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.tag = 1;
    [loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *enterGame = [UIButton buttonWithType:UIButtonTypeSystem];
    enterGame.frame = CGRectMake(50, 150, 80, 50);
    [enterGame setTitle:@"进入游戏" forState:UIControlStateNormal];
    enterGame.tag = 2;
    [enterGame addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterGame];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    payBtn.frame = CGRectMake(50, 200, 80, 50);
    [payBtn setTitle:@"支付" forState:UIControlStateNormal];
    payBtn.tag = 5;
    [payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    enterGame.enabled = NO;
    payBtn.enabled = NO;
    self.enterGame = enterGame;
    self.payBtn = payBtn;
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    changeBtn.frame = CGRectMake(50, 250, 80, 50);
    [changeBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    changeBtn.tag = 10;
    [changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}
- (void)btnAction:(UIButton *)sender
{
    if (sender.tag == 1) {
        [[QQ5SDK shareInstance] startSDKLoginCallBlock:^(id data) {
            NSLog(@"%@",data);
            self.enterGame.enabled = YES;
        }];
    }else if (sender.tag == 2){
        [[QQ5SDK shareInstance]enterGameRoleId:@"123" roleName:@"123" roleLevel:@"123" serverId:@"123" serverName:@"123" enterGameCallBack:^(id data) {
            self.payBtn.enabled = YES;
        }];
    }else if (sender.tag == 5){
        NSDate *date = [NSDate date];
        [[QQ5SDK shareInstance] initUserPayViewAmout:@"0.01" gameCoin:@"600" gameCoinName:@"金币" gameOrderId:[NSString stringWithFormat:@"%f_",[date timeIntervalSince1970]] extra:@"dasfdjaslkfjdsaklfjdslakf" withProductId:@"com.qq5SDK.num1" payCallBack:^(id data) {
            NSLog(@"%@",data);
        }];
    }else if (sender.tag == 3){
        sender.selected = !sender.selected;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:sender.selected] forKey:@"isAutoLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [QQ5SDK shareInstance].isAutoLogin = sender.selected;
    }else if (sender.tag == 10){
        [[QQ5SDK shareInstance] startSDKLoginCallBlock:^(id data) {
            
            self.enterGame.enabled = YES;
        }];
    }
}
- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //检测到摇动开始
    
    if (motion == UIEventSubtypeMotionShake){
        
    }
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动取消
    
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        [[QQ5SDK shareInstance]resetMenuView:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
