//
//  DAO.m
//  NavCtrl
//
//  Created by Jerry Chen on 1/10/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProducts+CoreDataClass.h"
#import "ManagedProducts+CoreDataProperties.h"

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
        [self initializeCoreData];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasRun"]){
            // App has run, fetch core data
            NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
            NSFetchRequest *fetchCompanies = [[NSFetchRequest alloc] initWithEntityName:@"ManagedCompany"];
            self.companyList = [[NSMutableArray alloc]init];
            self.managedCompanyList = [[managedObjectContext executeFetchRequest:fetchCompanies error:nil] mutableCopy];
            for (ManagedCompany *mC in self.managedCompanyList) {
                Company *c = [[Company alloc]init];
                c.name = mC.name;
                c.ticker = mC.ticker;
                c.price = [NSNumber numberWithDouble: mC.price];
                c.imageName = mC.imageName;
                c.logoImage = [UIImage imageNamed: mC.imageName];
                // ???
                for (ManagedProducts *mP in mC.product) {
                    Product *p = [[Product alloc]init];
                    p.name = mP.name;
                    p.url = mP.url;
                    p.imageUrl = mP.imageurl;
                    [c.productList addObject: p];
                }
                [self.companyList addObject:c];
            }
            // Get prices
            [self getPrices];
            
            dispatch_async(dispatch_get_main_queue(),^{
                [[NSNotificationCenter defaultCenter] postNotificationName: @"CoreDataCompaniesNotification" object:nil];
            });
        }
        else {
            [self loadStockComps];
        }
    }
    return self;
}

-(void) loadStockComps {
    // Apple
    // ======================================================================
    Company *apple = [[Company alloc]init];
    apple.name = @"Apple Inc.";
    apple.logoImage = [UIImage imageNamed:@"img-companyLogo_Apple"];
    apple.imageName = @"img-companyLogo_Apple";
    apple.ticker = @"AAPL";
    apple.price = @0;
    
    [apple.productList addObject:[[Product alloc] initWithName:@"iPhone 7" URL:@"http://www.apple.com/iphone-7/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_7_large.jpg"]];
    [apple.productList addObject:[[Product alloc]initWithName:@"iPhone 6S" URL:@"http://www.apple.com/iphone6S/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_6s_large.jpg"]];
    [apple.productList addObject:[[Product alloc]initWithName:@"iPhone SE" URL:@"http://www.apple.com/iphone-7/" andImageURL: @"http://images.apple.com/v/iphone/home/t/images/home/compare_iphone_se_large.jpg"]];
    
    // Google
    // ======================================================================
    Company *google = [[Company alloc]init];
    google.name = @"Alphabet Inc.";
    google.logoImage = [UIImage imageNamed:@"img-companyLogo_Google"];
    google.imageName = @"img-companyLogo_Google";
    google.ticker = @"GOOG";
    google.price = @0;
    
    [google.productList addObject:[[Product alloc]initWithName:@"Google Docs" URL:@"https://www.google.com/docs/about/" andImageURL: @""]];
    [google.productList addObject:[[Product alloc]initWithName:@"Google Maps" URL:@"https://maps.google.com/" andImageURL: @""]];
    
    // Twitter
    // ======================================================================
    Company *twitter = [[Company alloc]init];
    twitter.name = @"Twitter Inc.";
    twitter.logoImage = [UIImage imageNamed:@"img-companyLogo_Twitter"];
    twitter.imageName = @"img-companyLogo_Twitter";
    twitter.ticker = @"TWTR";
    twitter.price = @0;
    
    [twitter.productList addObject:[[Product alloc] initWithName:@"Twitter" URL:@"http://www.twitter.com/" andImageURL: @"https://lh3.ggpht.com/lSLM0xhCA1RZOwaQcjhlwmsvaIQYaP3c5qbDKCgLALhydrgExnaSKZdGa8S3YtRuVA=w300"]];
    [twitter.productList addObject:[[Product alloc]initWithName:@"Vine" URL:@"http://www.vine.com" andImageURL: @"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Vine_logo.svg/2000px-Vine_logo.svg.png"]];
    
    
    // Facebook
    // ======================================================================
    Company *facebook = [[Company alloc]init];
    facebook.name = @"Facebook Inc.";
    facebook.logoImage = [UIImage imageNamed:@"img-companyLogo_Facebook"];
    facebook.imageName = @"img-companyLogo_Facebook";
    facebook.ticker = @"FB";
    facebook.price = @0;
    
    
    // Tesla
    // ======================================================================
    Company *tesla = [[Company alloc]init];
    tesla.name = @"Tesla Inc.";
    tesla.logoImage = [UIImage imageNamed:@"img-companyLogo_Tesla"];
    tesla.imageName = @"img-companyLogo_Tesla";
    tesla.ticker = @"TSLA";
    tesla.price = @0;
    
    // Netflix
    // ======================================================================
    Company *netflix = [[Company alloc]init];
    netflix.name = @"Netflix Inc.";
    netflix.logoImage = [UIImage imageNamed:@"img-companyLogo_Netflix"];
    netflix.imageName = @"img-companyLogo_Netflix";
    netflix.ticker = @"NFLX";
    netflix.price = @0;
    
    // Nike
    // ======================================================================
    Company *nike = [[Company alloc]init];
    nike.name = @"Nike Inc.";
    nike.logoImage = [UIImage imageNamed:@"img-companyLogo_Nike"];
    nike.imageName = @"img-companyLogo_Nike";
    nike.ticker = @"NKE";
    nike.price = @0;
    
    // Amazon
    // ======================================================================
    Company *amazon = [[Company alloc]init];
    amazon.name = @"Amazon Inc.";
    amazon.logoImage = [UIImage imageNamed:@"img-companyLogo_Amazon"];
    amazon.imageName = @"img-companyLogo_Amazon";
    amazon.ticker = @"AMZN";
    amazon.price = @0;
    
    // Under Armour
    // ======================================================================
    Company *ua = [[Company alloc]init];
    ua.name = @"Under Armour Inc.";
    ua.logoImage = [UIImage imageNamed:@"img-companyLogo_UA"];
    ua.imageName = @"img-companyLogo_UA";
    ua.ticker = @"UAA";
    ua.price = @0;
    
    // Microsoft
    // ======================================================================
    Company *ms = [[Company alloc]init];
    ms.name = @"Microsoft Inc.";
    ms.logoImage = [UIImage imageNamed:@"img-companyLogo_MS"];
    ms.imageName = @"img-companyLogo_MS";
    ms.ticker = @"MSFT";
    ms.price = @0;
    
    
    // Add all the companies to the company list
    companyList = [[NSMutableArray alloc]initWithObjects: apple, google, twitter, facebook, tesla, netflix, nike, amazon, ua, ms, nil];
    // Get prices
    [self getPrices];
    
    // ======================================================================
    //
    //  Core Data
    //
    // ======================================================================
    
    // Initialize Core Data
    [self initializeCoreData];
    
    // Dump the companies and their product into managed objects
    for (Company *company in companyList) {
        ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
        mC.name = company.name;
        mC.ticker = company.ticker;
        mC.imageName = company.imageName;
        mC.price = [company.price doubleValue];
        // ??? crash ???
        for (Product *product in company.productList) {
            ManagedProducts *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProducts" inManagedObjectContext:self.managedObjectContext];
            mP.name = product.name;
            mP.url = product.url;
            mP.imageurl = product.imageUrl;
            mP.owner = mC;
            // Add this product to the company
        }
        //Add company to managed object
    }
    
    [self.managedObjectContext save:nil];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasRun"];
    
}

// ================================================================================================
//
                                 #pragma mark - GET Stock Prices
//
// ================================================================================================
- (void) getPrices{
    
    // Create URL String
    // NSString *URLString = @"http://finance.yahoo.com/d/quotes.csv?s=AAPL+GOOG+MSFT&f=sa";
    NSString *compTickerString;
    
    if (companyList.count > 0) {
        // Set the first ticker
        Company *firstComp = companyList[0];
        compTickerString = firstComp.ticker;
        
        // Add more tickers from the list
        for (int i = 1; i < companyList.count; i++) {
            Company *compToAdd = companyList[i];
            NSString *originalString = compTickerString;
            NSString *stringToAdd = [NSString stringWithFormat:@"+%@", compToAdd.ticker];
            compTickerString = [originalString stringByAppendingString:stringToAdd];
        }
        NSString * URLString = [[NSString alloc] initWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=so", compTickerString];
        
        // URL Request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        [request setURL:[NSURL URLWithString:URLString]];
        
        NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask *getData = [session dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       // Data downloaded in CSV
                                                       NSString *csvReturns = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                       NSLog(@"%@", csvReturns);
                                                       
                                                       // Turn CSV to Array
                                                       NSArray *companyArray = [csvReturns componentsSeparatedByString:@"\n"];
                                                       // "APPL",119.9800
                                                       
                                                       // Turn Company Array to Dictionary
                                                       NSMutableDictionary *companyDict = [[NSMutableDictionary alloc]init];
                                                       NSCharacterSet *quoteSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
                                                       
                                                       for (NSString *row in companyArray) {
                                                           if (row.length > 0) {
                                                               // parse individual row into an array
                                                               NSArray *company = [row componentsSeparatedByString:@","];
                                                               // Add the pair into company dictionary
                                                               [companyDict setObject: company[1] forKey:[company[0] stringByTrimmingCharactersInSet:quoteSet]];
                                                           }
                                                       }
                                                       
                                                       // Update the prices to match the dictionary
                                                       for (Company *company in companyList) {
                                                           company.price = [companyDict objectForKey:company.ticker];
                                                       }
                                                       //post a notification
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"PriceDownloadCompleteNotification"
                                                                                                               object:nil];

                                                       });
                                                                                                          }];
        
        [getData resume];
        
        
    } else {
        NSLog(@"There are no companies in companyList.");
    }
    return;

}

// ================================================================================================
//
                                    #pragma mark - Core Data
//
// ================================================================================================
- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    
    // Object Model - information
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    // storage and location of the model / data
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    // Object Context - similar to a service that handles data transaction
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // =========================== SHIT FOR LATER =================================
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    
    // UIManagedDocument
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Model.sqlite"];
    // Document States:
    // .Closed
    // .Normal
    // .SavingError
    // .EditingDisabled
    // .InConflict
    // UIManagedDocuments AUTOSAVE themselves
    // ??? OpenWithcompletionHandler ???
    
    // ============================================================================
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
}

// Create & Update Managed Objects
- (void)createManagedCompany:(Company*)company {
    // [self initializeCoreData];
    
    ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    mC.name = company.name;
    mC.ticker = company.ticker;
    mC.imageName = company.imageName;
    mC.price = 0;
    
    [self.managedObjectContext save:nil];

}

- (void)updateManagedCompany:(Company*)comp {

}

- (void)removeManagedCompany:(Company*)comp {
   // [self initializeCoreData];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    // [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@", compName]];
    NSMutableArray *managedCompanies = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    ManagedCompany *companyToDelete;
    for (ManagedCompany *mC in managedCompanies) {
        if ([mC.name isEqualToString: comp.name]) {
            companyToDelete = mC;
        }
    }
    [self.managedObjectContext deleteObject:companyToDelete];
    [self.managedObjectContext save:nil];

}

@end
