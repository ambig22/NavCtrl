//
//  ProductWebViewController.h
//  NavCtrl
//
//  Created by Jerry Chen on 1/9/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "Product.h"

@interface ProductWebViewController : CustomViewController
@property (retain, nonatomic) IBOutlet UIView *productView;
@property (retain, nonatomic) IBOutlet UIWebView *webView;

// Stores the active product that was passed from CompanyViewController
@property (retain, nonatomic) Product *product;

@end
