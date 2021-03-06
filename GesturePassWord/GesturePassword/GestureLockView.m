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

@property(nonatomic,copy)NSMutableString *verifyPassCode;

@property(nonatomic,copy)NSMutableString *tempVerifyPassCode;


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
    
    self.alertTitle.text = @"绘制解锁图案";
    
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
            
            bool writeTemp = NO;
            
            if (self.tempVerifyPassCode.length <= 0) {
                
                writeTemp = YES;
            }
            
            
            for (GestureView *gestureView in self.selectViewList) {
                
                if (writeTemp) {
                    
                    [self.tempVerifyPassCode appendString:[NSString stringWithFormat:@"%ld",gestureView.tag]];
                    
                }else{
                    
                    [self.verifyPassCode appendString:[NSString stringWithFormat:@"%ld",gestureView.tag]];
                }
                
            }
            
            self.finish = YES;
            
            if (_verifyTwoNum) {
                
                
                if (self.tempVerifyPassCode.length > 0 && self.verifyPassCode.length > 0) {
                    
                 
                    if ([self.tempVerifyPassCode isEqualToString:self.verifyPassCode]) {
                        
                        
                        
                        GestureError *error = [[GestureError alloc] initErrorCode:PASSCODE_SUCCESS withMessage:@"Success" withPassCode:self.verifyPassCode];
                        
                        [self backPage:error];
                        
                    }else{
                        
                        self.alertTitle.text = @"两次绘制图案不一致，请重新绘制";
                        
                        [self clearAllPassCodeStr];
                        
                    }
                    
                    
                }else{
                    
                    self.alertTitle.text = @"请再次绘制";
                    
                }
 

            }else{
                
                
                GestureError *error = [[GestureError alloc] initErrorCode:PASSCODE_SUCCESS withMessage:@"Success" withPassCode:self.tempVerifyPassCode];
    
                [self backPage:error];
                
            }
            
            
        }else{
            
            
            self.finish = NO;
            
            [self clearAllPassCodeStr];
            
            [self clearAllGuestureBtn];
            
            [self.selectViewList removeAllObjects];
        }
        
        
    }
 
}




- (void)layoutSubviews{
    
    [super layoutSubviews];
    
//    NSLog(@"<-- 6 %s , count = %@-->", __func__, @(count++));
    
    
    [self UIConfig];
    
    if (!self.isShowEchoView) {
        
        [self.guesEchoView setHidden:YES];
    }
    
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
        
        if (_lineNormalColor) {
            
            [_lineNormalColor set];
            
        }else{
            
            [[UIColor grayColor] set];
        }
        
    }
    
    
    
    
    path.lineWidth = 1;
    path.lineJoinStyle = kCGLineCapRound;
    path.lineCapStyle = kCGLineCapButt;
    [path stroke];
    
    
    
    
}


-(void)UIConfig{
    
    
    if (_isShowLine == YES) {
        
        for (GestureView *gestureView in _viewList) {
            gestureView.selectItemCenterBallColor = _selectItemCenterBallColor;
        }
        
    }else{
        
        for (GestureView *gestureView in _viewList) {
            gestureView.selectItemCenterBallColor = [UIColor clearColor];
        }
        _lineNormalColor = [UIColor clearColor];
        
    }
    
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

-(void)clearAllPassCodeStr{
    
    [self.tempVerifyPassCode deleteCharactersInRange:NSMakeRange(0, self.tempVerifyPassCode.length)];
    
    [self.verifyPassCode deleteCharactersInRange:NSMakeRange(0, self.verifyPassCode.length)];
}




-(void)backButtonClick{
    
    if (_backPage) {
        
        GestureError *error = [[GestureError alloc] initErrorCode:PASSCODE_BACKPAGE withMessage:@"back" withPassCode:@""];
        _backPage(error);
    }
    
}

-(void)backPage:(GestureError *)error{
    
    if (_backPage) {
        
        _backPage(error);
    }
    
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

- (NSMutableString *)verifyPassCode{
    
    if (!_verifyPassCode) {
        _verifyPassCode = [[NSMutableString alloc] init];
    }
    return _verifyPassCode;
    
}

- (NSMutableString *)tempVerifyPassCode{
    
    if (!_tempVerifyPassCode) {
        _tempVerifyPassCode = [[NSMutableString alloc] init];
    }
    return _tempVerifyPassCode;
    
    
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}


//- (void)willMoveToSuperview:(nullable UIView *)newSuperview
//{
//  NSLog(@"<-- 2 %s , count = %@-->", __func__, @(count++));
//}
//
//- (void)didMoveToSuperview
//{
//  NSLog(@"<-- 3 %s , count = %@-->", __func__, @(count++));
//}
//
//- (void)willMoveToWindow:(nullable UIWindow *)newWindow
//{
//  NSLog(@"<-- 4/7 %s , count = %@-->", __func__, @(count++));
//}
//
//- (void)didMoveToWindow
//{
//  NSLog(@"<-- 5/8 %s , count = %@-->", __func__, @(count++));
//}
//
//
//- (void)removeFromSuperview
//{
//  NSLog(@"<-- 9 %s , count = %@-->", __func__, @(count++));
//}
//
//- (void)dealloc
//{
//  NSLog(@"<-- 10 %s , count = %@-->", __func__, @(count++));
//}
  

@end
