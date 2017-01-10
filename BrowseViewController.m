//
//  BrowseViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "BrowseViewController.h"
#import "CompanyViewController.h"
#import "DAO.h"

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
    
    // DAO sharedDataManager
    self.sharedData = [DAO sharedDataManager];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Edit button in the Nav View Controller
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.title = @"Stock Tracker";
    
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
    return [self.sharedData.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    Company *currentCompany = self.sharedData.companyList[indexPath.row];
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
                                        [self.sharedData.companyList removeObjectAtIndex:indexPath.row];
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
    Company *companyToMove = self.sharedData.companyList[fromIndexPath.row];
    [self.sharedData.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.sharedData.companyList insertObject:companyToMove atIndex:toIndexPath.row];
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
    Company *currentCompany = self.sharedData.companyList[indexPath.row];
    companyVC.title = currentCompany.name;
    companyVC.company = currentCompany;
    [self.navigationController pushViewController:companyVC animated:YES];
    
}


@end
