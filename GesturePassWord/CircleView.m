//
//  CircleView.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "CircleView.h"

@interface CircleView()
@property(nonatomic,strong)UIColor *selectColor;
@end

@implementation CircleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _selectColor = [UIColor blackColor];
    }
    
    return self;
}


-(void)setSelectStatus:(BOOL)selectStatus{
    
    _selectStatus = selectStatus;
    
    [self setNeedsDisplay];
    
}


-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    
    CGContextFillRect(context, rect);
    
    CGContextAddEllipseInRect(context, rect);
    
    if (_selectStatus) {
        
        [[UIColor blackColor] set];
        
    }else{
        
        [[UIColor whiteColor] set];
    }
    CGContextFillPath(context);
    
}

@end
