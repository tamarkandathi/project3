//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Company;
@class Product;
@class ChildViewController;
extern NSString *downloadStockPricesNotification;
extern  NSString *kGenericUrl;
@interface DataAccessObject : NSObject
@property (retain, nonatomic) NSMutableArray *companies;

-(void)editProduct:(Product *)product atIndex:(NSIndexPath *)indexPath withProductName: (NSString *) productName fromCompany:(Company *)company;
-(void) addNewProduct:(Product*) product toCompany:(Company*) company;
-(NSMutableArray*) getAllProductsForCompany:(Company*) company;
+(instancetype) sharedDataAccessObject;
-(NSMutableArray*)retrieveData;
-(void) downloadStockPrices;

-(void) deleteCompany:(Company *) company;
-(void) deleteProduct:(Product*) product forCompany:(Company*) company;
-(void) addCompany: (Company*) company;
-(void) editCompany:(Company *) company withCompanyName:(NSString*) companyName;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
