//
//  GestureError.h
//  GesturePassWord
//
//  Created by 张宁 on 2020/10/23.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PASSCODE_SUCCESS,
    PASSCODE_BACKPAGE,
} PassCodeError;

@interface GestureError : NSObject

@property(nonatomic,assign)PassCodeError code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *passCode;

- (instancetype)initErrorCode:(PassCodeError)code withMessage:(NSString *)message withPassCode:(NSString *)passCode;

@end

NS_ASSUME_NONNULL_END
