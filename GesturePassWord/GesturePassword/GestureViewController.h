//
//  GestureViewController.h
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/28.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureError.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^BackPage)(GestureError *);

@interface GestureViewController : UIViewController

@property(nonatomic,copy)BackPage backPage;

@end

NS_ASSUME_NONNULL_END
