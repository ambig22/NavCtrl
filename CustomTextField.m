//
//  CustomTextField.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/11/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        CALayer *underlineborder = [CALayer layer];
        CGFloat borderWidth = 1;
        underlineborder.borderColor = [UIColor lightGrayColor].CGColor;
        underlineborder.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
        underlineborder.borderWidth = borderWidth;
        
        [self.layer addSublayer: underlineborder];
        
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
