//
//  BackButton.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/28.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextBeginPath(context);
    
    CGFloat view_W = rect.size.width;
    CGFloat view_H = rect.size.height;
    
    CGContextMoveToPoint(context, view_W/5, view_H/5);
    CGContextAddLineToPoint(context, view_W/5 * 4, view_H/5 * 4);

    
    CGContextMoveToPoint(context, view_W/5 * 4, view_H/5);
    CGContextAddLineToPoint(context, view_W/5, view_H/5 * 4);
    
    CGContextStrokePath(context);
}

@end
