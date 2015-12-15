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

@interface DataAccessObject : NSObject


@property (nonatomic, retain) NSMutableArray *companies;
-(NSMutableArray *)getAllCompaniesAndProducts;
-(void) editProduct: (Product*) product atIndex:(NSIndexPath*) indexPath fromCompany:(Company*) company;
-(void) addNewProduct:(Product*) productNew toCompany:(Company*) company;
-(NSMutableArray*) getAllProductsFromCompany:(Company*) company;
+(instancetype) sharedDataAccessObject;

@end
