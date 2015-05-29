//
//  JDLoginViewModel.m
//  JasonCaoDemoProject
//
//  Created by 曹 景成 on 15/5/27.
//  Copyright (c) 2015年 JasonCao. All rights reserved.
//

#import "JDLoginViewModel.h"
#import "MF_Base64Additions.h"

static NSString *const USERNAME_KEY = @"username";
static NSString *const PASSWORD_KEY = @"password";
static NSString *const ISREMEMBER_KEY = @"isremember";
static NSString *const ISAUTO_KEY = @"isauto";

@implementation JDLoginViewModel

-(instancetype)initWithDefauleModel{
    self = [super init];
    
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        RACChannelTo(self,username) = [defaults rac_channelTerminalForKey:USERNAME_KEY];
        RACChannelTo(self,isRememberPassword) = [defaults rac_channelTerminalForKey:ISREMEMBER_KEY];
        RACChannelTo(self,isAutoLogin) = [defaults rac_channelTerminalForKey:ISAUTO_KEY];
        
        RACChannelTerminal *defaultPasswordChannel = [defaults rac_channelTerminalForKey:PASSWORD_KEY];
        RACChannelTerminal *passwordChannel = RACChannelTo(self,password);
        
        [defaultPasswordChannel subscribe:passwordChannel];
        [passwordChannel subscribe:defaultPasswordChannel];
    }
    
    return self;
    
}

- (void)setIsRememberPassword:(NSNumber *)isRememberPassword {
    _isRememberPassword = isRememberPassword;
}


@end
