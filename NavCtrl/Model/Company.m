//
//  Company.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Company.h"


@implementation Company

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
    
        [self setCompanyName:[coder decodeObjectForKey:@"compName"]];
        
        [self setCompanyLogo: [coder decodeObjectForKey:@"compLogo"]];
        [self setCompanyStockCode: [coder decodeObjectForKey:@"compStCode"]];
        [self setCompanyStockPrice: [coder decodeObjectForKey:@"compStPrice"]];
        [self setCompanyProducts: [coder decodeObjectForKey:@"compProds"]];
        [self setCompanyStockPrices: [coder decodeObjectForKey:@"compStPrices"]];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.companyName forKey:@"compName"];
    [aCoder encodeObject:self.companyLogo forKey:@"compLogo"];
    [aCoder encodeObject:self.companyProducts forKey:@"compProds"];
    [aCoder encodeObject:self.companyStockCode forKey:@"compStCode"];
    [aCoder encodeObject:self.companyStockPrice forKey:@"compStPrice"];
    [aCoder encodeObject:self.companyStockPrices forKey:@"compStPrices"];
}


@end
