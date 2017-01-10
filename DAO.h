//
//  DAO.h
//  NavCtrl
//
//  Created by Jerry Chen on 1/10/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject {
    NSMutableArray *companyList;
}

@property (nonatomic, strong) NSMutableArray *companyList;

+ (id)sharedDataManager;

@end
