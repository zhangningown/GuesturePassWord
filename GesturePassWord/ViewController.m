//
//  ViewController.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/4/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "GestureViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
     GestureViewController *vc = [[GestureViewController alloc]init];
    
    __weak typeof(vc)weekSelfVc = vc;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;

    vc.backPage = ^(GestureError * _Nonnull error) {
      
        [weekSelfVc dismissViewControllerAnimated:YES completion:nil];
    };
   
    [self presentViewController:vc animated:YES completion:nil];
   
    
}

- (void)dealloc
{
    NSLog(@"释放了");
}

@end
