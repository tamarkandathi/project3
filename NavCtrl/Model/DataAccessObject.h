//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *companyStockPrices;
//-(void) getCompanies;
@property (nonatomic,retain) NSString *plistPath;
-(void) updateStockPrices;
+(instancetype)sharedInstance;
-(void) archiveObjects:(NSString*) filepath;
-(void)loadCompanies;

-(void)loadData;
-(void)save;

@end
