//
//  ViewController.m
//  SSPassWordDemo
//
//  Created by user on 2017/4/13.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ViewController.h"
#import "SSPassWordView.h"

@interface ViewController ()<SSPassWordViewDelegate>

@property (nonatomic, strong) SSPassWordView *passWordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _passWordView = [[SSPassWordView alloc] initWithFrame:CGRectMake(50, 150, 300, 60)];
    _passWordView.delegate = self;
    _passWordView.passWordNum = 6;
    _passWordView.clearDisplayRange= NSMakeRange(0, 4);
    //_passWordView.rectColor = [UIColor clearColor];
    [self.view addSubview:_passWordView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SSPassWordViewDelegate
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(SSPassWordView *)passWord {
    NSLog(@"======密码改变：%@",passWord.textStore);
}

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(SSPassWordView *)passWord {
    NSLog(@"+++++++密码输入完成");
    
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(SSPassWordView *)passWord {
    NSLog(@"-------密码开始输入");
}


@end
