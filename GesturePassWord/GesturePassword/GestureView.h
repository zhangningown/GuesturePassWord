//
//  GestureView.h
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GestureView : UIView
@property(nonatomic,assign)BOOL selectStatus;
@property(nonatomic,assign)BOOL isPathFill;
@property(nonatomic,strong)UIColor *selectItemCenterBallColor;

@end

NS_ASSUME_NONNULL_END
