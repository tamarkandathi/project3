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

@interface DataAccessObject : NSObject
@property (retain, nonatomic) NSMutableArray *companies;

-(void) addProduct:(Product*) product toCompany:(Company*) company;
-(NSMutableArray*) getAllProductsForCompany:(Company*) company;
+(instancetype) sharedDataAccessObject;
-(NSMutableArray*)retrieveData;
-(void) downloadStockPrices;

-(void)editProduct:(Product *)product atIndexPath:(NSIndexPath *)indexPath forCompany:(Company *)company;

-(void) deleteCompany:(Company *) company;
-(void) deleteProduct:(Product*) product atIndexPath:(NSIndexPath*) indexPath forCompany:(Company*) company;
-(void) addCompany: (Company*) company;
-(void) editCompany:(Company *) company atIndex: (NSIndexPath*) indexPath;
-(void) swapCompanies:(Company*) companyA :(Company*) companyB;
-(void) swapProducts:(Product*) productA :(Product*) productB;


@end
