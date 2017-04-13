//
//  SSPassWordView.m
//  COOPPasswordViewDemo
//
//  Created by user on 2017/4/11.
//  Copyright © 2017年 Stone.Sun. All rights reserved.
//

#import "SSPassWordView.h"

@interface SSPassWordView ()

@property (strong, nonatomic) NSMutableString *textStore;//保存密码的字符串

@property (assign, nonatomic) CGFloat itemMargin;

@end

@implementation SSPassWordView


static NSString  * const MONEYNUMBERS = @"0123456789";


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.opaque = NO;
        //self.layer.opaque = NO;
        self.textStore = [NSMutableString string];
        self.squareWidth = 45;
        self.passWordNum = 6;
        self.pointRadius = 6;
        self.itemMargin = 5.f;
        self.clearDisplayRange = NSMakeRange(0, self.passWordNum);
        self.cliptextType = SSCiphertextStar;
        self.rectColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.pointColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
        [self becomeFirstResponder];
        
    }
    return self;
}

/**
 *  设置正方形的边长
 */
- (void)setSquareWidth:(CGFloat)squareWidth {
    _squareWidth = squareWidth;
    [self setNeedsDisplay];
}

/**
 *  设置键盘的类型
 */
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

/**
 *  设置密码的位数
 */
- (void)setPassWordNum:(NSUInteger)passWordNum {
    _passWordNum = passWordNum;
    
    _squareWidth = (self.frame.size.width-2)/_passWordNum;      //2px用来预留边框，我是不是很机智😄
    
    [self setNeedsDisplay];
}


- (NSRange)clearDisplayRange{
    if (_clearDisplayRange.length == 0 || _clearDisplayRange.length == NSNotFound) {
        _clearDisplayRange = NSMakeRange(0, _passWordNum);
    }
    return _clearDisplayRange;
}





- (BOOL)becomeFirstResponder {
    if ([self.delegate respondsToSelector:@selector(passWordBeginInput:)]) {
        [self.delegate passWordBeginInput:self];
    }
    return [super becomeFirstResponder];
}

/**
 *  是否能成为第一响应者
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

#pragma mark - UIKeyInput
/**
 *  用于显示的文本对象是否有任何文本
 */
- (BOOL)hasText {
    return self.textStore.length > 0;
}

/**
 *  插入文本
 */
- (void)insertText:(NSString *)text {
    if (self.textStore.length < self.passWordNum) {
        //判断是否是数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MONEYNUMBERS] invertedSet];
        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [text isEqualToString:filtered];
        if(basicTest) {
            [self.textStore appendString:text];
            if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
                [self.delegate passWordDidChange:self];
            }
            if (self.textStore.length == self.passWordNum) {
                if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
                    [self.delegate passWordCompleteInput:self];
                }
            }
            [self setNeedsDisplay];
        }
    }else if (self.textStore.length == self.passWordNum) {
        if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
            [self.delegate passWordCompleteInput:self];
        }
        [self setNeedsDisplay];
    }
}

/**
 *  删除文本
 */
- (void)deleteBackward {
    if (self.textStore.length > 0) {
        [self.textStore deleteCharactersInRange:NSMakeRange(self.textStore.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
            [self.delegate passWordDidChange:self];
        }
    }
    [self setNeedsDisplay];
}



//// Only override drawRect: if you perform custom drawing.
//- (void)drawRect:(CGRect)rect {
//
//
//    
//    CGFloat height = rect.size.height;
//    CGFloat width = rect.size.width;
//    CGFloat x = (width - self.squareWidth*self.passWordNum - self.itemSpace*(self.passWordNum-1))/2.0+2;
//    CGFloat y = (height - self.squareWidth)/2.0;
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    //画外框
//    CGContextAddRect(context, CGRectMake( x, y, self.squareWidth*self.passWordNum+self.itemSpace*(self.passWordNum-1)-4, self.squareWidth));
//    CGContextSetLineWidth(context, 0.5);
//    CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    
//    //画竖条
//    for (int i = 0; i < self.passWordNum; i++) {
//        CGContextMoveToPoint(context, x+(i+1)*self.squareWidth+i*self.itemSpace+self.itemSpace/2, y);
//        CGContextAddLineToPoint(context, x+(i+1)*self.squareWidth+i*self.itemSpace+self.itemSpace/2, y+self.squareWidth);
//        CGContextClosePath(context);
//    }
//    
//    
////    //画横线
////    for (int i = 0; i < self.passWordNum; i++) {
////        CGContextMoveToPoint(context, x+i*(self.squareWidth+self.itemSpace), y+self.squareWidth + 10);
////        CGContextAddLineToPoint(context, x+(i*self.squareWidth), y+self.squareWidth + 10);
////        CGContextClosePath(context);
////        /*
////        CGContextMoveToPoint(context, x+(i-1)*self.squareWidth, y+self.squareWidth);
////        CGContextAddLineToPoint(context, x+i*self.squareWidth, y+self.squareWidth);
////        CGContextClosePath(context);
////         */
////    }
//   
//    CGContextDrawPath(context, kCGPathFillStroke);
//    CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
//    
//    //段落格式
//    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    textStyle.alignment = NSTextAlignmentCenter;//水平居中
//    //字体
//    UIFont  *font = [UIFont systemFontOfSize:13.0];
//    //构建属性集合
//    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
//    
//    
//    //画黑点
//    for (int i = 0; i < self.textStore.length; i++) {
//
//        if (i >= self.clearDisplayRange.location && i < self.clearDisplayRange.location + self.clearDisplayRange.length) {
//            NSAttributedString *numStr = [[NSAttributedString alloc] initWithString:[self.textStore substringWithRange:NSMakeRange(i, 1)]
//                                                                        attributes:attributes];
//            CGPoint point = CGPointMake(x+i*self.squareWidth + i*self.itemSpace + self.squareWidth/2.0 - numStr.size.width/2, y+self.squareWidth/2 - numStr.size.height/2);
//            [numStr drawAtPoint:point];
//        }else {
//
//            CGContextAddArc(context,  x+i*self.squareWidth + i*self.itemSpace + self.squareWidth/2.0, y+self.squareWidth/2, self.pointRadius, 0, M_PI*2, YES);
//            CGContextDrawPath(context, kCGPathFill);
//        }
//    }
//
//}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    CGFloat x = (width - self.squareWidth*self.passWordNum)/2.0;
    CGFloat y = (height - self.squareWidth)/2.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
//    //画外框
//    CGContextAddRect(context, CGRectMake( x, y, self.squareWidth*self.passWordNum, self.squareWidth));
//    CGContextSetLineWidth(context, 0.5);
//    CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    //画竖条
//    for (int i = 1; i <= self.passWordNum; i++) {
//        CGContextMoveToPoint(context, x+i*self.squareWidth, y);
//        CGContextAddLineToPoint(context, x+i*self.squareWidth, y+self.squareWidth);
//        CGContextClosePath(context);
//    }
    
    //画横线
    for (int i = 0; i < self.passWordNum; i++) {
        CGContextMoveToPoint(context, x+(i*self.squareWidth)+self.itemMargin, y+self.squareWidth);
        CGContextAddLineToPoint(context, x+(i+1)*self.squareWidth-self.itemMargin, y+self.squareWidth);
        CGContextClosePath(context);
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
    
    //段落格式
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    //字体
    UIFont  *font = [UIFont systemFontOfSize:13.0];
    //构建属性集合
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
    
    
    //画黑点
    for (int i = 0; i < self.textStore.length; i++) {
        
        if (i >= self.clearDisplayRange.location && i < self.clearDisplayRange.location + self.clearDisplayRange.length) {
            NSAttributedString *numStr = [[NSAttributedString alloc] initWithString:[self.textStore substringWithRange:NSMakeRange(i, 1)]
                                                                         attributes:attributes];
            CGPoint point = CGPointMake(x+i*self.squareWidth + self.squareWidth/2.0 - numStr.size.width/2, y+self.squareWidth/2 - numStr.size.height/2);
            [numStr drawAtPoint:point];
        }else {
            if (self.cliptextType == SSCiphertextStar) {
                NSAttributedString *numStr = [[NSAttributedString alloc] initWithString:@"*"
                                                                             attributes:attributes];
                CGPoint point = CGPointMake(x+i*self.squareWidth + self.squareWidth/2.0 - numStr.size.width/2, y+self.squareWidth/2 - numStr.size.height/2);
                [numStr drawAtPoint:point];
            }else {
                CGContextAddArc(context,  x+i*self.squareWidth + self.squareWidth/2.0, y+self.squareWidth/2, self.pointRadius, 0, M_PI*2, YES);
                CGContextDrawPath(context, kCGPathFill);
            }
            

        }
    }
    
}




@end
