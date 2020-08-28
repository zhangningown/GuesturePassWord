//
//  GuestureEchoView.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/27.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "GuestureEchoView.h"
#import "GestureView.h"
@implementation GuestureEchoView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
     
        self.backgroundColor = UIColor.whiteColor;
        [self initSubviews];
    }
    return self;
    
}

-(void)setSelectItem:(NSArray *)selectItem{
    
    _selectItem = selectItem;
    
    if (_selectItem.count == 0) {
        
        for (GestureView *tempView in self.subviews) {
            
            [tempView setIsPathFill:NO];
        }
        
    }
    
    for (NSNumber *tempNum in _selectItem) {
        
        GestureView *tempGesture = self.subviews[[tempNum integerValue]];
        
        [tempGesture setIsPathFill:YES];
        
    }
    
    
}


-(void)initSubviews{
    
    
    for (int i = 0; i < 9; i++) {
        
        GestureView *gestureView = [[GestureView alloc] init];
        gestureView.tag = i;
        [self addSubview:gestureView];
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;

    int cols = 3;//总列数

    CGFloat x = 0,y = 0,w = 9,h = 9;


    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);//间距

    CGFloat col = 0;
    CGFloat row = 0;

    for (int i = 0; i < count; i++) {

        col = i % cols;
        row = i / cols;

        x = margin + (w+margin)*col;
        y = margin + (w+margin)*row;

        GestureView *gestureView = self.subviews[i];
        gestureView.layer.masksToBounds = YES;
        gestureView.layer.cornerRadius = w/2;
        gestureView.frame = CGRectMake(x, y, w, h);
    }
    
    
}


@end
