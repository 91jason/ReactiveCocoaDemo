//
//  PRPToggleButton+CustomImageSetter.m
//  RealSolutions
//
//  Created by 曹 景成 on 14-11-15.
//  Copyright (c) 2014年 Realdesign. All rights reserved.
//

#import "PRPToggleButton+CustomImageSetter.h"

@implementation PRPToggleButton (CustomImageSetter)

- (void)setCustomImageName:(NSString *)imageName {
    NSString *n = [NSString stringWithFormat:@"%@_n",imageName];
    NSString *h = [NSString stringWithFormat:@"%@_h",imageName];
    
    [self setOffImage:[UIImage imageNamed:n]];
    [self setImage:[UIImage imageNamed:n] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:h] forState:UIControlStateHighlighted];
    [self setOnImage:[UIImage imageNamed:h]];
    [self setImage:[UIImage imageNamed:h] forState:UIControlStateSelected];
}

- (void)setCustomBGName:(NSString *)bgName {
    NSString *n = [NSString stringWithFormat:@"%@_n",bgName];
    NSString *h = [NSString stringWithFormat:@"%@_h",bgName];
    
    [self setOffbgImage:[UIImage imageNamed:n]];
//    [self setBackgroundImage:[UIImage imageNamed:n] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:h] forState:UIControlStateHighlighted];
    [self setOnbgImage:[UIImage imageNamed:h]];
//    [self setBackgroundImage:[UIImage imageNamed:h] forState:UIControlStateSelected];
}

- (void)setCustomTitle:(NSString *)title {
    [self setOnString:title];
    [self setTitle:title forState:UIControlStateNormal];
//    [self setOffString:title];
    [self setTitle:title forState:UIControlStateSelected];
}

@end
