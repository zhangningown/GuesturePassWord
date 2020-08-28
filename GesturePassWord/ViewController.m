//
//  ViewController.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/4/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "ViewController.h"

#import "GestureViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    GestureViewController *vc = [[GestureViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

@end
