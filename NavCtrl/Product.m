//
//  Product.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithName: (NSString*)name URL: (NSString*)url andImageURL: (NSString*)imageUrl {
    self = [super init];
    
    self.name = name;
    self.url = url;
    self.imageUrl = imageUrl;
    
    return self;
}

@end
