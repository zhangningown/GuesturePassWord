//
//  GestureLockView.h
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackPage)(void);
@interface GestureLockView : UIView

@property(nonatomic,copy)BackPage backPage;

@end

NS_ASSUME_NONNULL_END
