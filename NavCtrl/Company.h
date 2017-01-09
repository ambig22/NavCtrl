//
//  Company.h
//  NavCtrl
//
//  Created by Jerry Chen on 1/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *logoImage;
@property (strong, nonatomic) NSString *ticker;
@property (strong, nonatomic) NSNumber *price;

@property (strong, nonatomic) NSMutableArray *productList;

@end
