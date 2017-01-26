//
//  EditViewController.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/11/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
// ================================================================================================
//
                            #pragma mark - viewDidLoad & viewDidAppear
//
// ================================================================================================

- (void)viewDidLoad {
    
//    UIImage *image = [[UIImage alloc]init];
//    image.renderingMode
    
    [super viewDidLoad];
    self.sharedData = [DAO sharedDataManager];
    
    // Set textField Delegates
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    
    // ======================================================================
    //
    // Dynamic textField Data
    //
    // ======================================================================
    if (self.viewControllerType == companyNew || self.viewControllerType == companyEdit) {
        self.textField1.placeholder = @"Company Name";
        self.textField2.placeholder = @"Ticker Symbol";
        self.textField3.placeholder = @"Icon File Name";
        
        // testing
        self.textField3.text = @"img-companyLogo_Rocket";
        
        if (self.viewControllerType == companyEdit) {
            self.textField1.text = self.company.name;
            self.textField2.text = self.company.ticker;
            self.textField3.text = @"img-companyLogo_Rocket";
            
        }
    }
    else {
        self.textField1.placeholder = @"Product Name";
        self.textField2.placeholder = @"Product Link URL";
        self.textField3.placeholder = @"Product Image URL";
        
        // testing
        self.textField3.text = @"https://i1.wp.com/hypebeast.com/image/2017/01/adidas-originals-stan-smith-boost-metallic-silver-sneaker-0.jpg";
        
        if (self.viewControllerType == productEdit) {
            
        }

    }
    
    // Add gesture recognition for exiting edit mode
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];


    // Cancel button for left nav
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissVC)] autorelease];
    // Save button for right nav
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)] autorelease];

    
}

- (void) dismissVC {
     [self.navigationController popViewControllerAnimated:YES];
}

// ================================================================================================
//
                                     #pragma mark - SAVE
//
// ================================================================================================
- (void) save {
    // companyNew
    if (self.viewControllerType == companyNew) {
        Company *comp = [[Company alloc]init];
        comp.name = self.textField1.text;
        comp.ticker = self.textField2.text;
        comp.logoImage = [UIImage imageNamed:self.textField3.text];
        
        // Add to array
        [self.sharedData.companyList addObject:comp];
        
        // Pop VC
        [self.navigationController popViewControllerAnimated:YES];
    }
    // companyEdit
    else if (self.viewControllerType == companyEdit) {
        // ??? overwrite the object with the same name ???
    }
    // productNew
    else if (self.viewControllerType == productNew) {
        [self.company.productList addObject:[[Product alloc] initWithName: self.textField1.text URL:self.textField2.text andImageURL: self.textField3.text]];
        
        // Pop VC
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    // productEdit
    else if (self.viewControllerType == productEdit) {
        
    }
}

// ================================================================================================
//
                                 #pragma mark - Keyboard & Input
//
// ================================================================================================

-(void)dismissKeyboard
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
}

// Dismiss keyboard when user tap 'return'
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
}

// Keyboard Float

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"%f", keyboardSize.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.viewOGRect = self.scrollView.frame;
        CGRect f = self.scrollView.frame;
        // adjust the height of the scroll view
        f.size.height =   (self.view.frame.size.height) - (keyboardSize.height); // + self.navigationController.navigationBar.frame.size.height + statusHeight
        self.scrollView.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.frame = self.viewOGRect;
    }];
}

// ================================================================================================
//
                                    #pragma mark - dealloc
//
// ================================================================================================

- (void)dealloc {
    [_textField1 release];
    [_textField2 release];
    [_textField3 release];
    // [_view release];
    [_deleteBtn release];
    [_scrollView release];
    [super dealloc];
}
@end
