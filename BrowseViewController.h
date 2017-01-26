//
//  BrowseViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//  TableView Tutorial: https://www.youtube.com/watch?v=lbelYsPgdZI

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@class ChildViewController;

@interface BrowseViewController : CustomViewController <UITableViewDelegate, UITableViewDataSource>


@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic, strong) DAO *sharedData;
@property (retain, nonatomic) IBOutlet UIView *emptyListView;

@end
