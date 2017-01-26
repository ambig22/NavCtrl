//
//  BrowseViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "BrowseViewController.h"
#import "CompanyViewController.h"
#import "EditViewController.h"
#import "DAO.h"

@interface BrowseViewController ()

@end

@implementation BrowseViewController

// ================================================================================================
//
                            #pragma mark - viewDidLoad & viewDidAppear
//
// ================================================================================================
- (void)viewDidLoad
{

    [super viewDidLoad];
    // ======================================================================
    //
    //  Notifications
    //
    // ======================================================================
    // PriceDownloadCompleteNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePriceLabels)
                                                 name:@"PriceDownloadCompleteNotification"
                                               object:nil];
    
    // CoreDataCompaniesNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTableView)
                                                 name:@"CoreDataCompaniesNotification"
                                               object:nil];
    
    // ======================================================================
    
    // Fade in Loading Label
    self.loadingLabel.alpha = 0;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.loadingLabel.alpha = 1;}
                     completion:nil];
    
    // DAO sharedDataManager
    self.sharedData = [DAO sharedDataManager];
 
    // Edit button for left nav
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // Add button for right nav
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompany)] autorelease];

    //self.navigationItem.rightBarButtonItem =

    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Stock Tracker";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelectionDuringEditing = YES;
    
}

-(void)viewDidAppear:(BOOL)animated {
    // Clears selection when returned from sub VC
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing: editing animated:YES];
}

-(void)addCompany {
    EditViewController *newCompVC = [[EditViewController alloc] init];
    newCompVC.title = @"Add Company";
    newCompVC.viewControllerType = companyNew;
    
    [self.navigationController pushViewController:newCompVC animated:YES];

}

-(void)updatePriceLabels {
    [self.tableView reloadData];
    
    // Fade out loading label
    
    [UIView animateWithDuration:1 delay:0.3 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.loadingLabel.alpha = 0;}
                     completion:nil];
}

-(void)updateTableView {
    Company *test = self.sharedData.companyList[0];
    [self.tableView reloadData];
    
}

// ================================================================================================
//
                          #pragma mark - UITableView DataSource & Delegate
//
// ================================================================================================

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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - $%@", currentCompany.ticker, currentCompany.price];
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
                                        // Remove the the item from the companyList array
                                        [self.sharedData.companyList removeObjectAtIndex:indexPath.row];
                                        
                                        // Remove the item from the tableView
                                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                        
                                        // Reload the list after the delete animation
                                        [NSTimer scheduledTimerWithTimeInterval:.6
                                                                         target:self.tableView
                                                                       selector:@selector(reloadData)
                                                                       userInfo:nil
                                                                        repeats:NO];
                                        
                                        // If the list is empty, show the empty-list overlay
                                        if (self.sharedData.companyList.count  == 0) {
                                            self.emptyListView.hidden = NO;
                                        } else {
                                            self.emptyListView.hidden = YES;
                                        }
                                    }];
    button.backgroundColor = UIColorFromRGB(0x984141);
    return @[button];
}

// REARRANGE: Enable drag/drop to move table view items
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
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
    Company *currentCompany = self.sharedData.companyList[indexPath.row];
    if (tableView.isEditing == false) {
        // If not in edit mode:
        // Set title to the selected item
        CompanyViewController *companyVC = [[CompanyViewController alloc]init];
        companyVC.title = currentCompany.name;
        companyVC.company = currentCompany;
        [self.navigationController pushViewController:companyVC animated:YES];
    } else {
        // If it's in editing mode:
        // Enter editVC
        EditViewController *editCompVC = [[EditViewController alloc] init];
        editCompVC.title = @"Edit Company";
        editCompVC.viewControllerType = companyEdit;
        editCompVC.company = currentCompany;
        [self.navigationController pushViewController:editCompVC animated:YES];
    }
    
    
    // If in edit mode:
    
}

/*
- (void)dealloc {
    [_view release];
    [_tableView release];
    [super dealloc];
}
 */
- (void)dealloc {
    [_emptyListView release];
    [_loadingLabel release];
    [super dealloc];
}
@end
