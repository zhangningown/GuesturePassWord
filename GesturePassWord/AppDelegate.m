//
//  AppDelegate.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/4/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    
    _window.backgroundColor = UIColor.whiteColor;
    
    _window.rootViewController = [[ViewController alloc] init];
    
    [_window makeKeyAndVisible];
    
    
    return YES;
}





@end
