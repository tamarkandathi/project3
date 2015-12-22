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

-(void) editProduct: (Product*) product atIndex:(NSIndexPath*) indexPath fromCompany:(Company*) company;
-(void) addNewProduct:(Product*) product toCompany:(Company*) company;
-(NSMutableArray*) getAllProductsForCompany:(Company*) company;
+(instancetype) sharedDataAccessObject;
-(NSMutableArray*)retrieveData;
-(void) downloadStockPrices;
@end
