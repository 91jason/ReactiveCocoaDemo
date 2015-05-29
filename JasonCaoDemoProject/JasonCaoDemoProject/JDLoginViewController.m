//
//  JDLoginViewController.m
//  JasonCaoDemoProject
//
//  Created by 曹 景成 on 15/5/27.
//  Copyright (c) 2015年 JasonCao. All rights reserved.
//

#import "JDLoginViewController.h"
#import "JDLoginViewModel.h"
#import "MF_Base64Additions.h"
#import "PRPToggleButton.h"

#define CACHESPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0]

@interface JDLoginViewController ()

@property (nonatomic, strong) JDLoginViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet PRPToggleButton *rememberPasswordButton;
@property (weak, nonatomic) IBOutlet PRPToggleButton *autoLoginButton;


@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation JDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",CACHESPATH);
    
    //抽取界面的Signal
    RACSignal *usernameTextFieldSignal = [self.userNameTextField rac_textSignal];
    RACSignal *passwordTextFieldSignal = [self.passwordTextField rac_textSignal];
    RACSignal *rememberButtonSignal = [self.rememberPasswordButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    RACSignal *autoButtonSignal = [self.autoLoginButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    self.viewModel = [[JDLoginViewModel alloc]initWithDefauleModel];
    //根据viewModel初始化界面的值
    self.userNameTextField.text = self.viewModel.username;
    self.passwordTextField.text =  [NSString stringFromBase64String:self.viewModel.password];
    [self.rememberPasswordButton setOn:self.viewModel.isRememberPassword.boolValue];
    [self.autoLoginButton setOn:self.viewModel.isAutoLogin.boolValue];
    //viewModel 与 界面进行绑定 双向绑定 双向水管
    RAC(self.viewModel, username) = usernameTextFieldSignal;
    RAC(self.viewModel,password) = [passwordTextFieldSignal
                                    map:^id(NSString *value) {
                                        return value.base64String;
                                    }];
    //验证用户密码是否有效,组合水管，单输出，双向绑定
    RAC(self.loginButton,enabled) = [RACSignal combineLatest:@[usernameTextFieldSignal,passwordTextFieldSignal]
                                                      reduce:^id(NSString *username, NSString *password){
                                                          return @(username.length>0&&password.length);
                                                      }];
    //单向水管,附加操作
    [[[rememberButtonSignal
       map:^id(PRPToggleButton *value) {
        return @(value.isOn);
    }]
      doNext:^(NSNumber *x) {
           if (!x.boolValue && self.viewModel.isAutoLogin.boolValue) {
               self.viewModel.isAutoLogin = @NO;
               [self.autoLoginButton setOn:NO];
           }
       }]
     subscribeNext:^(NSNumber *x) {
          self.viewModel.isRememberPassword = x;
     }];
    
    //单向水管,附加操作
    [[[autoButtonSignal
     map:^id(PRPToggleButton *value) {
         return @(value.isOn);
     }]
     doNext:^(NSNumber *x) {
         if (x.boolValue && !self.viewModel.isRememberPassword.boolValue) {
             self.viewModel.isRememberPassword = @YES;
             [self.rememberPasswordButton setOn:YES];
         }
     }]
    subscribeNext:^(NSNumber *x) {
        self.viewModel.isAutoLogin = x;
        
    }];
}
 
/*
//异步API 创建信号
- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        [self.signInService
         signInWithUsername:self.usernameTextField.text
         password:self.passwordTextField.text
         complete:^(BOOL success){
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}
//信号中的信号
[[[self.signInButton
   rac_signalForControlEvents:UIControlEventTouchUpInside]
  flattenMap:^id(id x){
      return[self signInSignal];
  }]
 subscribeNext:^(NSNumber*signedIn){
     BOOL success =[signedIn boolValue];
     self.signInFailureText.hidden = success;
     if(success){
         [self performSegueWithIdentifier:@"signInSuccess" sender:self];
     }
 }];
 */

@end
