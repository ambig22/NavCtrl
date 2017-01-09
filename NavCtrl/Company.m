//
//  Company.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company


- (instancetype)init
{
    self = [super init];
    if (self) {
        _productList = [[NSMutableArray alloc]init];    }
    return self;
}

@end
