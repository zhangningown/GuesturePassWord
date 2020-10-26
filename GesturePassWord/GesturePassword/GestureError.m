//
//  GestureError.m
//  GesturePassWord
//
//  Created by 张宁 on 2020/10/23.
//  Copyright © 2020 zhangning. All rights reserved.
//

#import "GestureError.h"

/*
 
 
 @property(nonatomic,assign)PassCodeError code;
 @property(nonatomic,copy)NSString *message;
 @property(nonatomic,copy)NSString *passCode;
 */
@implementation GestureError

- (instancetype)initErrorCode:(PassCodeError)code withMessage:(NSString *)message withPassCode:(NSString *)passCode
{
    self = [super init];
    if (self) {
        
        _code = code;
        _message = message;
        _passCode = passCode;
        
    }
    return self;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"错误码 = %lu,描述 = %@,密码 = %@",(unsigned long)_code,_message,_passCode];
}

@end
