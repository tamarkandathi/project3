//
//  Company.h
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (retain,nonatomic) NSMutableArray *companyProducts;
@property (retain, nonatomic) NSString *companyName;
@property (retain, nonatomic) NSString *companyLogo;
@property (retain, nonatomic) NSMutableArray *companyStockPrices;
@property (retain , nonatomic) NSString *companyStockCode;


@end
