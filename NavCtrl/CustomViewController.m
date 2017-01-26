//
//  CustomViewController.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/10/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

// Custom VC has back button in the nav

- (void)viewDidLoad {
    [super viewDidLoad];
      
    // Custom Back Button in Nav
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    // Change rendering mode to allow tint color
    buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:buttonImage forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    
    backBtn.frame = CGRectMake(0, 0, 25, 12);
    [backBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = customBarItem;
//    [customBarItem release];
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
