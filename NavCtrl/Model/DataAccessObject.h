//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *companyStockPrices;

-(void) updateStockPrices;


-(void)loadData;

@end
