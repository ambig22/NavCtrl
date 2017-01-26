//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import "EditViewController.h"

@interface CompanyViewController : CustomViewController <UITableViewDelegate, UITableViewDataSource>

// View properties
@property (retain, nonatomic) IBOutlet UIView *companyView;
@property (retain, nonatomic) IBOutlet UIImageView *logoImageView;
@property (retain, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (retain, nonatomic) IBOutlet UITableView *productTableView;

// DAO
@property (retain, nonatomic) DAO *sharedData;

// Stores the active company that was passed from BrowseViewController
@property (retain, nonatomic) Company *company;

// Web View for product links
@property (retain, nonatomic) UIWebView *webView;

@end
