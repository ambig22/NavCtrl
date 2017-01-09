//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "GlobalConstants.h"

@interface CompanyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UIView *companyView;

@property (retain, nonatomic) IBOutlet UIImageView *logoImageView;
@property (retain, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (retain, nonatomic) IBOutlet UITableView *productTableView;

// Stores the active company that was passed from BrowseViewController
@property (retain, nonatomic) Company *company;

// Web View for product links
@property (retain, nonatomic) UIWebView *webView;

@end
