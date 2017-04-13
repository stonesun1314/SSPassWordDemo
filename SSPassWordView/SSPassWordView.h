//
//  SSPassWordView.h
//  COOPPasswordViewDemo
//
//  Created by user on 2017/4/11.
//  Copyright © 2017年 Stone.Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SSCiphertextType) {
    SSCiphertextStar,           //星星
    SSCiphertextDot,            //圆点
};

@class SSPassWordView;

@protocol SSPassWordViewDelegate <NSObject>


@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(SSPassWordView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(SSPassWordView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(SSPassWordView *)passWord;


@end

@interface SSPassWordView : UIView<UIKeyInput>

@property (assign, nonatomic) SSCiphertextType cliptextType;    //密文显示到样式,默认SSCiphertextStar
@property (assign, nonatomic) NSUInteger passWordNum;   //密码的位数
@property (assign, nonatomic) CGFloat squareWidth;  //正方形的大小
@property (assign, nonatomic) CGFloat pointRadius;  //黑点的半径
@property (strong, nonatomic) UIColor *pointColor;  //黑点的颜色
@property (strong, nonatomic) UIColor *rectColor;   //边框的颜色
@property (assign, nonatomic) NSRange clearDisplayRange; //明文显示的range，默认{0,passWordNum-1}        //
@property (weak, nonatomic) id<SSPassWordViewDelegate> delegate;
@property (strong, nonatomic, readonly) NSMutableString *textStore;//保存密码的字符串

@end
