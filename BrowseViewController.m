//
//  BrowseViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "BrowseViewController.h"
#import "CompanyViewController.h"

@interface BrowseViewController ()

@end

@implementation BrowseViewController

// ================================================================================================
//
                                     #pragma mark - viewDidLoad
//
// ================================================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Edit button in the Nav View Controller
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // ======================================================================
    //
    //  Create Companies
    //
    // ======================================================================
    self.title = @"Stock Tracker";
    
    // Apple
    // ======================================================================
    Company *apple = [[Company alloc]init];
    apple.name = @"Apple Inc.";
    apple.logoImage = [UIImage imageNamed:@"img-companyLogo_Apple"];
    apple.ticker = @"AAPL";
    apple.price = @150;
    
    [apple.productList addObject:[[Product alloc] initWithName:@"iPhone 7" URL:@"http://www.apple.com/iphone-7/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_7_large.jpg"]];
    [apple.productList addObject:[[Product alloc]initWithName:@"iPhone 6S" URL:@"http://www.apple.com/iphone6S/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_6s_large.jpg"]];
    [apple.productList addObject:[[Product alloc]initWithName:@"iPhone SE" URL:@"http://www.apple.com/iphone-7/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_se_large.jpg"]];
    
    // Google
    // ======================================================================
    Company *google = [[Company alloc]init];
    google.name = @"Alphabet Inc.";
    google.logoImage = [UIImage imageNamed:@"img-companyLogo_Google"];
    google.ticker = @"GOOG";
    google.price = @806;
    
    [google.productList addObject:[[Product alloc]initWithName:@"Google Docs" URL:@"https://www.google.com/docs/about/" andImageURL: @""]];
    [google.productList addObject:[[Product alloc]initWithName:@"Google Maps" URL:@"https://maps.google.com/" andImageURL: @""]];

    // Twitter
    // ======================================================================
    Company *twitter = [[Company alloc]init];
    twitter.name = @"Twitter Inc.";
    twitter.logoImage = [UIImage imageNamed:@"img-companyLogo_Twitter"];
    twitter.ticker = @"TWTR";
    twitter.price = @17;
    
    [twitter.productList addObject:[[Product alloc] initWithName:@"Twitter" URL:@"http://www.twitter.com/" andImageURL: @"https://lh3.ggpht.com/lSLM0xhCA1RZOwaQcjhlwmsvaIQYaP3c5qbDKCgLALhydrgExnaSKZdGa8S3YtRuVA=w300"]];
    [twitter.productList addObject:[[Product alloc]initWithName:@"Vine" URL:@"http://www.vine.com" andImageURL: @"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Vine_logo.svg/2000px-Vine_logo.svg.png"]];
    
    // Add all the companies to the company list
    self.companyList = [[NSMutableArray alloc]initWithObjects: apple, google, twitter, nil];
    
}

// ================================================================================================
//
                          #pragma mark - UITableView DataSource & Delegate
//
// ================================================================================================

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    Company *currentCompany = self.companyList[indexPath.row];
    cell.textLabel.text = currentCompany.name;
    cell.imageView.image = currentCompany.logoImage;
    cell.detailTextLabel.text = currentCompany.ticker;
    cell.detailTextLabel.textColor = UIColorFromRGB(0x777777);
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = UIColorFromRGB(0xfafafa);
    cell.selectedBackgroundView = selectionColor;
    
    return cell;
}

// Set height of the cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 70;
}

// ======================================================================
//
//  Delete & Rearrange Rows
//
// ======================================================================
// DELETE: Custom Delete Button
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *delete, NSIndexPath *indexPath)
                                    {
                                        [self.companyList removeObjectAtIndex:indexPath.row];
                                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                        
                                        [NSTimer scheduledTimerWithTimeInterval:.6
                                                                         target:self.tableView
                                                                       selector:@selector(reloadData)
                                                                       userInfo:nil
                                                                        repeats:NO];
                                    }];
    button.backgroundColor = UIColorFromRGB(0x984141);
    return @[button];
}

// REARRANGE: Enable drag/drop to move table view items
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// REARRANGE: Move Row in Table View
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    Company *companyToMove = self.companyList[fromIndexPath.row];
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:companyToMove atIndex:toIndexPath.row];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

// ================================================================================================
//
                                     #pragma mark - Actoins
//
// ================================================================================================
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set title to the selected item
    CompanyViewController *companyVC = [[CompanyViewController alloc]init];
    Company *currentCompany = self.companyList[indexPath.row];
    companyVC.title = currentCompany.name;
    companyVC.company = currentCompany;
    [self.navigationController pushViewController:companyVC animated:YES];
    
}


@end
