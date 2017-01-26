//
//  EditViewController.h
//  NavCtrl
//
//  Created by Jerry Chen on 1/11/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "CustomTextField.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

// enum for VC type
typedef enum formType {companyNew, companyEdit, productNew, productEdit} formType;

@interface EditViewController : CustomViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property CGRect viewOGRect;
@property (nonatomic, strong) DAO *sharedData;

@property (retain, nonatomic) Product *product;
@property (retain, nonatomic) Company *company;

@property formType viewControllerType;
//@property enum formType viewControllerType;

@property (retain, nonatomic) IBOutlet CustomTextField *textField1;
@property (retain, nonatomic) IBOutlet CustomTextField *textField2;
@property (retain, nonatomic) IBOutlet CustomTextField *textField3;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtn;

@end
