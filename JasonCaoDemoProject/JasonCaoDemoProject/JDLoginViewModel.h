//
//  JDLoginViewModel.h
//  JasonCaoDemoProject
//
//  Created by 曹 景成 on 15/5/27.
//  Copyright (c) 2015年 JasonCao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDLoginViewModel : NSObject

@property (nonatomic, strong, readonly) UIImage *userPic;
@property (nonatomic, strong, readwrite) NSNumber *isAutoLogin;
@property (nonatomic, strong, readwrite) NSNumber *isRememberPassword;

@property (nonatomic, strong, readwrite) NSString *username;
@property (nonatomic, strong, readwrite) NSString *password;

-(instancetype)initWithDefauleModel;

@end
