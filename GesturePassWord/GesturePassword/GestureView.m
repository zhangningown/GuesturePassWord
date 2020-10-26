//
//  GestureView.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "GestureView.h"
#import "CircleView.h"

@interface GestureView()

@property(nonatomic,strong)CircleView *cirView;

@end
@implementation GestureView



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.whiteColor;
 

    }
    
    return self;
}


-(void)setSelectStatus:(BOOL)selectStatus{
    _selectStatus = selectStatus;
    [self.cirView setSelectStatus:selectStatus];
    
}

-(void)setIsPathFill:(BOOL)isPathFill{
    
    _isPathFill = isPathFill;
    
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    
    
    [super drawRect:rect];
    
    /*画填充圆
     */
    //上线文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    [[UIColor grayColor] set];
    //设置圆边框宽度
    CGContextSetLineWidth(context, 1);
    //绘制圆
    //上下文、圆心、半径、弧度
    //最右侧为0
    //逆时针顺时针绘制
    CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/2 - 1, 0, 2*M_PI, 0);
    
    self.cirView.selectItemCenterBallColor = _selectItemCenterBallColor;
    
    
    if (_isPathFill) {
        CGContextDrawPath(context, kCGPathFill);
        [self.cirView setSelectStatus:YES];
        
    }else{
        
        CGContextDrawPath(context, kCGPathStroke);
        [self.cirView setSelectStatus:NO];
    }
    

}



- (void)setNeedsDisplay{
    [super setNeedsDisplay];
    
//    NSLog(@"setNeedsDisplay");
}
- (void)setNeedsDisplayInRect:(CGRect)rect{
    [super setNeedsDisplayInRect:rect];
//    NSLog(@"setNeedsDisplayInRect");
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self addSubview:self.cirView];
    self.cirView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    
}

- (CircleView *)cirView{
    
    if (!_cirView) {
        
        _cirView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.width/3)];
    }
    
    return _cirView;
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    [super drawLayer:layer inContext:ctx];
    
   
    
    
}

@end
