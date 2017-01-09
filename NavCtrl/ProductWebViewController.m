//
//  ProductWebViewController.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/9/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductWebViewController.h"

@interface ProductWebViewController ()

@end

@implementation ProductWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load Initial URL
    NSURL *url = [NSURL URLWithString: self.product.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_webView release];
    [_productView release];
    [super dealloc];
}
@end
