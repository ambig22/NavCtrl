//
//  Product.h
//  NavCtrl
//
//  Created by Jerry Chen on 1/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *imageUrl;

-(id)initWithName: (NSString*)name URL: (NSString*)url andImageURL: (NSString*)imageUrl;

@end
