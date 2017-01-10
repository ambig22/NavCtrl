//
//  DAO.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/10/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

@synthesize companyList; // ??? what's this ???

// ================================================================================================
//
                                 #pragma mark Singleton Methods
//
// ================================================================================================

// Class Method that creates the sharedCompanyList
+ (id)sharedDataManager {
    static DAO *sharedDataManager = nil;
    // static variables willl only get created one time during program execution
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

- (id)init {
    if (self = [super init]) {
        // ======================================================================
        //
        //  Init with default companies
        //
        // ======================================================================
        
        // Apple
        // ======================================================================
        Company *apple = [[Company alloc]init];
        apple.name = @"Apple Inc.";
        apple.logoImage = [UIImage imageNamed:@"img-companyLogo_Apple"];
        apple.ticker = @"AAPL";
        apple.price = @150;
        
        [apple.productList addObject:[[Product alloc] initWithName:@"iPhone 7" URL:@"http://www.apple.com/iphone-7/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_7_large.jpg"]];
        [apple.productList addObject:[[Product alloc]initWithName:@"iPhone 6S" URL:@"http://www.apple.com/iphone6S/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_6s_large.jpg"]];
        [apple.productList addObject:[[Product alloc]initWithName:@"iPhone SE" URL:@"http://www.apple.com/iphone-7/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_se_large.jpg"]];
        
        // Google
        // ======================================================================
        Company *google = [[Company alloc]init];
        google.name = @"Alphabet Inc.";
        google.logoImage = [UIImage imageNamed:@"img-companyLogo_Google"];
        google.ticker = @"GOOG";
        google.price = @806;
        
        [google.productList addObject:[[Product alloc]initWithName:@"Google Docs" URL:@"https://www.google.com/docs/about/" andImageURL: @""]];
        [google.productList addObject:[[Product alloc]initWithName:@"Google Maps" URL:@"https://maps.google.com/" andImageURL: @""]];
        
        // Twitter
        // ======================================================================
        Company *twitter = [[Company alloc]init];
        twitter.name = @"Twitter Inc.";
        twitter.logoImage = [UIImage imageNamed:@"img-companyLogo_Twitter"];
        twitter.ticker = @"TWTR";
        twitter.price = @17;
        
        [twitter.productList addObject:[[Product alloc] initWithName:@"Twitter" URL:@"http://www.twitter.com/" andImageURL: @"https://lh3.ggpht.com/lSLM0xhCA1RZOwaQcjhlwmsvaIQYaP3c5qbDKCgLALhydrgExnaSKZdGa8S3YtRuVA=w300"]];
        [twitter.productList addObject:[[Product alloc]initWithName:@"Vine" URL:@"http://www.vine.com" andImageURL: @"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Vine_logo.svg/2000px-Vine_logo.svg.png"]];
        
        // Add all the companies to the company list
        companyList = [[NSMutableArray alloc]initWithObjects: apple, google, twitter, nil];
        
    }
    return self;
}

@end
