//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
#import "qcdDemoAppDelegate.h"
#import "Company.h"
#import "Product.h"
#import <CoreData/CoreData.h>
#import "ManagedCompany.h"
#import "ManagedProduct.h"
NSString *kGenericUrl = @"http://turntotech.io/";
NSString *downloadStockPricesNotification = @"downloadStockPricesNotification";
@implementation DataAccessObject

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(instancetype)sharedDataAccessObject
{
    static dispatch_once_t cp_singleton_once_token;
    static DataAccessObject *sharedDataAccessObject;
    
    dispatch_once(&cp_singleton_once_token, ^{
        sharedDataAccessObject = [[self alloc] init];
    });
    return sharedDataAccessObject;
}

#pragma mark - Data persistence helper methods

-(void) editCompany:(Company *) company withCompanyName:(NSString*) companyName {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"companyName == %@", companyName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    ManagedCompany *fetchedCompany = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]objectAtIndex:0];
    if (fetchedCompany == nil) {
        NSLog(@"error %@", error.userInfo);
    } else {
        fetchedCompany.companyName = company.companyName;
        fetchedCompany.companyLogo = company.companyLogo;
        fetchedCompany.companyStockCode = company.companyStockCode;
        [self saveContext];
    }
}

-(void)editProduct:(Product *)product atIndex:(NSIndexPath *)indexPath withProductName: (NSString *) productName fromCompany:(Company *)company {
    
    NSMutableArray *companyProducts = [self getAllProductsForCompany:company];
    [companyProducts replaceObjectAtIndex:indexPath.row withObject:product];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"managedCompany.companyName == %@ AND productName == %@", company.companyName, productName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    ManagedProduct *fetchedProduct = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] objectAtIndex:0];
    
    if (fetchedProduct == nil) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    } else {
        fetchedProduct.productName = product.productName;
        fetchedProduct.productLogo = product.productLogo;
        fetchedProduct.productUrl = product.productUrl;
        [self saveContext];
    }
    
}
-(void)addNewProduct:(Product *)product toCompany:(Company *)company {
    [company.companyProducts addObject:product];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"companyName == %@", company.companyName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    ManagedCompany *fetchedCompany = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]objectAtIndex:0];
    if (fetchedCompany == nil) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    } else {
        NSEntityDescription *productEntity = [NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
        ManagedProduct *managedProduct = [[ManagedProduct alloc] initWithEntity:productEntity insertIntoManagedObjectContext:self.managedObjectContext];
        managedProduct.productName = product.productName;
        managedProduct.productLogo = product.productLogo;
        managedProduct.productUrl = product.productUrl;
        
        [fetchedCompany addManagedCompanyProductsObject:managedProduct];
        [self saveContext];
    }
    
}

-(void) deleteCompany:(Company *) company {
    
    [self.companies removeObject:company];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext: self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyName == %@", company.companyName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedCompany = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedCompany == nil) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    } else {
        [self.managedObjectContext deleteObject:[fetchedCompany objectAtIndex:0]];
        [self saveContext];
    }
}

-(void) deleteProduct:(Product*) product forCompany:(Company*) company {
    [company.companyProducts removeObject:product];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"managedCompany.companyName == %@ AND productName == %@", company.companyName, product.productName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedProduct = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedProduct == nil) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    } else {
        [self.managedObjectContext deleteObject:fetchedProduct[0]];
        [self saveContext];
    }
}

-(void) addCompany: (Company*) company {
    [self.companies addObject:company];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    ManagedCompany *managedCompany = [[ManagedCompany alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    managedCompany.companyName = company.companyName;
    managedCompany.companyLogo = company.companyLogo;
    managedCompany.companyStockCode = company.companyStockCode;
    [self saveContext];
}

#pragma mark - Retrieving data

-(NSMutableArray *)getAllProductsForCompany:(Company *)company {
    NSMutableArray *products = [[NSMutableArray alloc] init];
    products = company.companyProducts;
    return products;
}

-(void) downloadStockPrices {
    NSString *stockCodesURL = @"";

    for(int i = 0;i < self.companies.count;i++) {
        Company *company = [self.companies objectAtIndex:i];
        stockCodesURL = [stockCodesURL stringByAppendingString:company.companyStockCode];
        if (i != [self.companies count] - 1) {
            stockCodesURL = [stockCodesURL stringByAppendingString:@"+"];
        }
    }
    
    stockCodesURL = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a",stockCodesURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:stockCodesURL] completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error){
                                          if (!error) {
                                              NSString *stocks = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                              NSMutableArray *companyStockPrices = (NSMutableArray*)[stocks componentsSeparatedByString:@"\n"];
                                              [companyStockPrices removeLastObject];
                                              
                                              for (int i = 0; i < self.companies.count; i++) {
                                                  Company *company = [self.companies objectAtIndex:i];
                                                  if (companyStockPrices[i] != nil) {
                                                      company.companyStockPrice = companyStockPrices[i];
                                                  } else {
                                                      company.companyStockPrice = @"N/A";
                                                  }
                                              }
                                              [[NSNotificationCenter defaultCenter] postNotificationName:downloadStockPricesNotification object: self];
                                              
                                          } else {
                                              NSLog(@"%@", error.userInfo);
                                              //display an alert here
                                          }
                                      }];
        [dataTask resume];
}

-(NSMutableArray*)retrieveData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"companyName" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    } else if (fetchedObjects.count == 0) {
        [self saveData];
        fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
    self.companies = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < fetchedObjects.count; i++) {
        Company *company = [[Company alloc] init];
        company.companyName = [fetchedObjects[i] companyName];
        company.companyLogo = [fetchedObjects[i] companyLogo];
        company.companyStockCode = [fetchedObjects[i] companyStockCode];
        company.companyProducts = [[NSMutableArray alloc] init];
        NSArray *companyProductsArray = [[fetchedObjects[i] managedCompanyProducts] allObjects];
        
        for (int j = 0; j < companyProductsArray.count; j++) {
            Product *product = [[Product alloc] init];
            product.productName = [companyProductsArray[j] productName];
            product.productLogo = [companyProductsArray[j] productLogo];
            product.productUrl = [companyProductsArray[j] productUrl];
            company.companyProducts[j] = product;
        }
        
        self.companies[i] = company;
    }
    
    return self.companies;
}

-(void) saveData {
    //APPLE
    ManagedCompany *apple = (ManagedCompany*)[NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    apple.companyName = @"Apple mobile devices";
    apple.companyLogo = @"AppleLogo.png";
    apple.companyStockCode = @"AAPL";
    
    ManagedProduct *iPad = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    iPad.productName = @"iPad";
    iPad.productLogo = @"iPad.jpeg";
    iPad.productUrl = @"https://www.apple.com/ipad/";
    
    ManagedProduct *iPodTouch = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    iPodTouch.productName = @"iPod Touch";
    iPodTouch.productLogo = @"iPodTouch.jpeg";
    iPodTouch.productUrl = @"https://www.apple.com/ipod/";
    
    ManagedProduct *iPhone = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    iPhone.productLogo = @"iPhone.jpeg";
    iPhone.productName = @"iPhone";
    iPhone.productUrl = @"https://www.apple.com/iphone/";
    
    apple.managedCompanyProducts = [NSSet setWithObjects:iPad,iPodTouch,iPhone, nil];
    
    //SAMSUNG
    ManagedCompany *samsung = (ManagedCompany*)[NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    samsung.companyName = @"Samsung mobile devices";
    samsung.companyLogo = @"SamsungLogo.jpeg";
    samsung.companyStockCode = @"005930.KS";
    
    ManagedProduct *galaxyS4 = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    galaxyS4.productName = @"Galaxy S4";
    galaxyS4.productLogo = @"GalaxyS4.jpeg";
    galaxyS4.productUrl = @"http://www.samsung.com/us/mobile/cell-phones/SM-G928VZDAVZW";
    
    ManagedProduct *galaxyNote = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    galaxyNote.productName = @"Galaxy Note";
    galaxyNote.productLogo = @"GalaxyNote.jpeg";
    galaxyNote.productUrl = @"http://www.samsung.com/us/mobile/cell-phones/all-products?filter=galaxy-note";
    
    ManagedProduct *galaxyTab = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    galaxyTab.productName = @"Galaxy Tab";
    galaxyTab.productLogo = @"GalaxyTab.jpeg";
    galaxyTab.productUrl = @"http://www.samsung.com/us/mobile/galaxy-tab/";
    
    samsung.managedCompanyProducts = [NSSet setWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
    
    //MOTOROLA
    ManagedCompany *motorola = (ManagedCompany*)[NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    motorola.companyName = @"Motorola mobile devices";
    motorola.companyLogo = @"MotorolaLogo.jpeg";
    motorola.companyStockCode = @"066570.KS";
    
    ManagedProduct *droidTurbo = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    droidTurbo.productName = @"Droid Turbo";
    droidTurbo.productLogo = @"MotorolaDroidTurbo.jpeg";
    droidTurbo.productUrl = @"https://www.motorola.com/us/smartphones/droid-turbo/droid-turbo-pdp.html";
    
    ManagedProduct *droid3 = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    droid3.productName = @"Droid 3";
    droid3.productLogo = @"MotorolaDroid3.jpeg";
    droid3.productUrl = @"https://www.motorola.com/us/DROID-3-BY-MOTOROLA/73138.html";
    
    ManagedProduct *droidMax = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    droidMax.productName = @"Droid MAX";
    droidMax.productLogo = @"MotorolaDroidMAX.jpeg";
    droidMax.productUrl = @"https://www.motorola.com/us/smartphones/droid-maxx/m-droid-maxx.html";
    
    motorola.managedCompanyProducts = [NSSet setWithObjects:droidTurbo, droid3, droidMax, nil];
    
    //HTC
    ManagedCompany *htc = (ManagedCompany*)[NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    htc.companyName = @"HTC mobile devices";
    htc.companyLogo = @"HTCLogo.jpeg";
    htc.companyStockCode = @"2498.TW";
    
    ManagedProduct *droidDna = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    droidDna.productName = @"Droid DNA";
    droidDna.productLogo = @"HTCDroidDNA.jpeg";
    droidDna.productUrl = @"https://www.htc.com/us/smartphones/droid-dna-by-htc/";
    
    ManagedProduct *oneM8 = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    oneM8.productName = @"One M8";
    oneM8.productLogo = @"HTCOneM8.jpeg";
    oneM8.productUrl = @"https://www.htc.com/us/smartphones/htc-one-m8/";
    
    ManagedProduct *desire816 = (ManagedProduct*) [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    desire816.productName = @"Desire 816";
    desire816.productLogo = @"HTCDesire816.jpeg";
    desire816.productUrl = @"https://www.htc.com/us/smartphones/htc-desire-816/";
    
    htc.managedCompanyProducts = [NSSet setWithObjects: droidDna, oneM8, desire816, nil];

    NSError *error = [[NSError alloc] init];
    if (! [self.managedObjectContext save:&error]) {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

#pragma mark - Core data stack getters
- (NSURL *)applicationDocumentsDirectory {
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return url;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NavCtrlModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NavCtrl.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



@end
