//
//  GestureViewController.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/28.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "GestureViewController.h"
#import "GestureLockView.h"
@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    GestureLockView *lockView = [[GestureLockView alloc] initWithFrame:self.view.bounds];
    
    lockView.verifyTwoNum = YES;
    
    lockView.backPage = _backPage;
    
//    lockView.lineNormalColor = [UIColor redColor];
    
    lockView.isShowLine = YES;
    
    lockView.isShowEchoView = YES;
    
//    [lockView setSelectItemCenterBallColor:[UIColor blueColor]];
    
    [self.view addSubview:lockView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
