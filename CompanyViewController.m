//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductWebViewController.h"
#import "DAO.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

// ================================================================================================
//
                                    #pragma mark - viewDidLoad
//
// ================================================================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.sharedData = [DAO sharedDataManager];
    
    // Navigation buttons
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct)] autorelease];

    
    // General Info
    self.logoImageView.image = self.company.logoImage;
    self.companyNameLabel.text = self.company.name;
    self.navigationController.navigationBar.translucent = NO;
    
    // Products
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.productTableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.productTableView setEditing: editing animated:YES];
}

-(void)addProduct {
    EditViewController *newProdVC = [[EditViewController alloc] init];
    newProdVC.title = @"Add Product";
    newProdVC.viewControllerType = productNew;
    newProdVC.company = self.company;
    
    [self.navigationController pushViewController:newProdVC animated:YES];
    
}


// ================================================================================================
//
                        #pragma mark - UITableView DataSource & Delegate
//
// ================================================================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.company.productList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    Product *currentProduct = self.company.productList[indexPath.row];
    cell.textLabel.text = currentProduct.name;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentProduct.imageUrl]]];
    cell.detailTextLabel.text = @"This is where the price goes";
    cell.detailTextLabel.textColor = UIColorFromRGB(0x777777);
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = UIColorFromRGB(0xfafafa);
    cell.selectedBackgroundView = selectionColor;
    
    return cell;
}

// Set height of the cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 80;
}

// Custom Delete Button
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *delete, NSIndexPath *indexPath)
                                    {
                                        [self.company.productList removeObjectAtIndex:indexPath.row];
                                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                        
                                        [NSTimer scheduledTimerWithTimeInterval:.6
                                                                         target:self.productTableView
                                                                       selector:@selector(reloadData)
                                                                       userInfo:nil
                                                                        repeats:NO];
                                    }];
    button.backgroundColor = UIColorFromRGB(0x984141);
    return @[button];
}

// ================================================================================================
//
                                    #pragma mark - Actions
//
// ================================================================================================
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set title to the selected item
    ProductWebViewController *productVC = [[ProductWebViewController alloc]init];
    Product *productSelected = self.company.productList[indexPath.row];
    productVC.product = productSelected;
    [self.navigationController pushViewController:productVC animated:YES];

}

// ================================================================================================
//
                             #pragma mark - Old Shit to be Deleted
//
// ================================================================================================

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Table view data source

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



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



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)dealloc {
    [_productView release];
    [_logoImageView release];
    [_companyNameLabel release];
    [_productTableView release];
    [super dealloc];
}
 
  */

@end
