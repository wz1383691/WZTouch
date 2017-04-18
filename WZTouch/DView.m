//
//  DView.m
//  WZTouch
//
//  Created by james on 2017/4/18.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import "DView.h"

@implementation DView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //打印响应链
//    UIResponder * next = [self nextResponder];
//    NSMutableString * prefix = @"--".mutableCopy;
//    NSLog(@"%@", [self class]);
//    
//    while (next != nil) {
//        NSLog(@"%@%@", prefix, [next class]);
//        [prefix appendString: @"--"];
//        next = [next nextResponder];
//    }
    
    NSLog(@"我是d我响应le");
    [super touchesBegan:touches withEvent:event];
}

@end
