//
//  BrowseViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//  TableView Tutorial: https://www.youtube.com/watch?v=lbelYsPgdZI

#import <UIKit/UIKit.h>
#import "GlobalConstants.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@class ChildViewController;

@interface BrowseViewController : UITableViewController

@property (nonatomic, strong) DAO *sharedData;

@end
