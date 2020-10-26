//
//  GestureLockView.h
//  GesturePassWord
//
//  Created by 张宁 on 2020/8/26.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureError.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^BackPage)(GestureError *);
@interface GestureLockView : UIView

//回调
@property(nonatomic,copy)BackPage backPage;

//是否校验两次
@property(nonatomic,assign)bool verifyTwoNum;


//线条正常状态的颜色 默认灰色
@property (nonatomic, strong) UIColor *lineNormalColor;

//item中间球选中颜色
@property (nonatomic, strong) UIColor *selectItemCenterBallColor;

//是否回显轨迹
@property (nonatomic, assign)bool isShowEchoView;

//是否显示轨迹/显示 显示默认
@property (nonatomic, assign)bool isShowLine;


@end

NS_ASSUME_NONNULL_END




