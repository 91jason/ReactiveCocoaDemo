/***
 * Excerpted from "iOS Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/cdirec for more book information.
***/
//
//  PRPToggleButton.m
//  ToggleButton
//
//  Created by Matt Drance on 11/18/09.
//  Copyright 2009 Bookhouse Software, LLC. All rights reserved.
//

#import "PRPToggleButton.h"

@interface PRPToggleButton ()

@end


@implementation PRPToggleButton

@synthesize on;
@synthesize autotoggleEnabled;

@synthesize onImage;
@synthesize offImage;
@synthesize onbgImage;
@synthesize offbgImage;
@synthesize onColor;
@synthesize offColor;

+ (id)buttonWithOnImage:(UIImage *)onImage 
               offImage:(UIImage *)offImage 
       highlightedImage:(UIImage *)highlightedImage {
    PRPToggleButton *button;
    button = [self buttonWithType:UIButtonTypeCustom];
    button.onImage = onImage;
    button.offImage = offImage;
    [button setImage:offImage forState:UIControlStateNormal];
    [button setImage:highlightedImage 
                      forState:UIControlStateHighlighted];
    button.autotoggleEnabled = YES; 
    return button;
}

// Set up default auto toggle if loaded from IB
- (void)awakeFromNib {    
    self.autotoggleEnabled = YES;
    self.onImage = [self imageForState:UIControlStateSelected];
    self.offImage = [self imageForState:UIControlStateNormal];
    self.onbgImage = [self backgroundImageForState:UIControlStateSelected];
    self.offbgImage = [self backgroundImageForState:UIControlStateNormal];
    self.onString = [self titleForState:UIControlStateSelected];
    self.offString = [self titleForState:UIControlStateNormal];
    self.onColor = [self titleColorForState:UIControlStateSelected];
    self.offColor = [self titleColorForState:UIControlStateNormal];
    
    [self setImage:nil forState:UIControlStateSelected];
    [self setBackgroundImage:nil forState:UIControlStateSelected];
    [self setTitle:@"" forState:UIControlStateSelected];
    
}

#pragma mark Toggle support
// Change the selected state, UIButton will update appearance automatically
- (BOOL)toggle {
    self.on = !self.on;
    return self.on;
}

- (void)setOn:(BOOL)onBool {
    if (on != onBool) {
        on = onBool;
        [self setImage:(on ? self.onImage : self.offImage) 
                        forState:UIControlStateNormal];
        
        [self setBackgroundImage:(on ? self.onbgImage : self.offbgImage) forState:UIControlStateNormal];
        
        [self setTitle:(on ? self.onString : self.offString) forState:UIControlStateNormal];
       
        [self setTitleColor:(on ? onColor : offColor) forState:UIControlStateNormal];
        
    }
}

// Detect a "touchUpInside" and auto-toggle if so configured
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    if (self.touchInside && self.autotoggleEnabled) {
        [self toggle];
    }
}

@end