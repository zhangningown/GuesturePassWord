//
//  ViewController.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/4/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "GestureView.h"
#import "GestureLockView.h"
#import "GuestureEchoView.h"
@interface ViewController ()
@property(nonatomic,strong)CircleView *tempView;
@property(nonatomic,strong)GestureView *tempView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
//    _tempView2 = [[GestureView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_tempView2];
    
    GestureLockView *tempView = [[GestureLockView alloc] initWithFrame:self.view.bounds];
    
    [self setValue:tempView forKey:@"view"];
   
    
    
    // Do any additional setup after loading the view.
}



@end
