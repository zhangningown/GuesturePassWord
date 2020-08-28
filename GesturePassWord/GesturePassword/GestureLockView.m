//
//  GestureLockView.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "GestureLockView.h"
#import "GestureView.h"
#import "GuestureEchoView.h"
#import "BackButton.h"

@interface GestureLockView()

@property(nonatomic,assign)CGPoint currentPoint;

@property(nonatomic,strong)NSMutableArray *selectViewList;

@property(nonatomic,assign)BOOL finish;

@property(nonatomic,strong)NSMutableArray *viewList;

@property(nonatomic,strong)NSMutableArray *selectCount;

@property(nonatomic,strong)GuestureEchoView *guesEchoView;

@property(nonatomic,strong)BackButton *backButton;

@property(nonatomic,strong)UILabel *alertTitle;

@end


@implementation GestureLockView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
     
        self.backgroundColor = UIColor.whiteColor;
        [self initSubviews];
    }
    return self;
    
}


-(void)initSubviews{
    
    self.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:pan];
    
    for (int i = 0; i < 9; i++) {
        
        GestureView *gestureView = [[GestureView alloc] init];
        gestureView.tag = i;
        [self.viewList addObject:gestureView];
        [self addSubview:gestureView];
    }
    
    
    
    [self addSubview:self.guesEchoView];
    
    
    [self addSubview:self.backButton];
    
    
    [self addSubview:self.alertTitle];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    _currentPoint = [pan locationInView:self];
    
    [self setNeedsDisplay];
    
    for (GestureView *gestureView in self.viewList) {
        if (CGRectContainsPoint(gestureView.frame, _currentPoint) && gestureView.selectStatus ==  NO) {
                [gestureView setSelectStatus:YES];
                [self.selectViewList addObject:gestureView];
        }
    }

    [self layoutIfNeeded];
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.selectViewList.count >=4) {
            
            self.finish = YES;
            
        }else{
            
            self.finish = NO;
            
            [self clearAllGuestureBtn];
            
            [self.selectViewList removeAllObjects];
        }
        
        
    }
    
}



- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger count = self.viewList.count;

    int cols = 3;//总列数

    CGFloat x = 0,y = 0,w = 0,h = 0;

    if ([UIScreen mainScreen].bounds.size.width == 320) {
        w = 50;
        h = 50;
    } else {
        w = 70;
        h = 70;
    }

    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);//间距

    CGFloat col = 0;
    CGFloat row = 0;

    for (int i = 0; i < count; i++) {

        col = i % cols;
        row = i / cols;

        x = margin + (w+margin)*col;

        y = margin + (w+margin)*row;

        if ([UIScreen mainScreen].bounds.size.width == 480) { // 适配4寸屏幕
            y = (w + margin) * row + (self.bounds.size.height*1/3);
        }else {
            y = margin +(w + margin) * row + (self.bounds.size.height*1/3);
        }

        GestureView *gestureView = self.viewList[i];
        gestureView.frame = CGRectMake(x, y, w, h);
    }
    
    
}

-(void)drawRect:(CGRect)rect{
    
    if (_selectViewList.count  == 0) {
        
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i<self.selectViewList.count; i++) {
        
        GestureView *tempView = self.selectViewList[i];
        
        if (i == 0) {
            
            [path moveToPoint:tempView.center];
            self.guesEchoView.selectItem = @[];
            [self.selectCount removeAllObjects];
            
        }else{
            
            [path addLineToPoint:tempView.center];
        }
        
    }
    
    if (self.finish) {
        
        [[UIColor clearColor] set];
        [self clearAllGuestureBtn];
        
    }else{
        
        [path addLineToPoint:_currentPoint];
        
        [[UIColor grayColor] set];
    }
    
    
    
    
    path.lineWidth = 1;
    path.lineJoinStyle = kCGLineCapRound;
    path.lineCapStyle = kCGLineCapButt;
    [path stroke];
    
    
    
    
}



-(NSMutableArray *)selectViewList{
    
    if (!_selectViewList) {
        
        _selectViewList = [[NSMutableArray alloc] init];
    }
    return _selectViewList;
}


-(NSMutableArray *)viewList{
    
    if (!_viewList) {
           
           _viewList = [[NSMutableArray alloc] init];
       }
       return _viewList;
}
-(NSMutableArray *)selectCount{
    
    if (!_selectCount) {
           
           _selectCount = [[NSMutableArray alloc] init];
       }
       return _selectCount;
}

- (BOOL)finish{
    
    if (!_finish) {
        _finish = NO;
    }
    return _finish;
}


- (void)clearAllGuestureBtn{
    
    for (GestureView *tempView in self.selectViewList) {
        
        [tempView setSelectStatus:NO];
        
        
        if (self.finish) {
            
            [self.selectCount addObject:[NSNumber numberWithInteger:tempView.tag]];
            
            self.guesEchoView.selectItem = self.selectCount;
            
        }
        
    }
    
    self.finish = NO;
    
    [self.selectViewList removeAllObjects];
}


- (GuestureEchoView *)guesEchoView{
    
    if (!_guesEchoView) {
        
        _guesEchoView = [[GuestureEchoView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        [_guesEchoView setCenter:CGPointMake(self.center.x, self.center.y/5*2)];
    }
    return _guesEchoView;
    
}

- (BackButton *)backButton{
    
    if (!_backButton) {
        
        _backButton = [[BackButton alloc] initWithFrame:CGRectMake(30, self.center.y/6, 28, 28)];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backButton;
    
    
}

- (UILabel *)alertTitle{
    
    
    if (!_alertTitle) {
        _alertTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _alertTitle.textAlignment = NSTextAlignmentCenter;
        _alertTitle.text = @"绘制解锁图案";
        _alertTitle.font = [UIFont systemFontOfSize:15];
        _alertTitle.textColor = UIColor.grayColor;
        [_alertTitle setCenter:CGPointMake(self.center.x, self.guesEchoView.bounds.size.height + self.guesEchoView.frame.origin.y + 20)];
    }
    return _alertTitle;
}

-(void)backButtonClick{
    
    if (_backPage) {
        
        _backPage();
    }
    
}


@end
