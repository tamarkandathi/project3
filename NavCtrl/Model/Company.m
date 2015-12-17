//
//  Company.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Company.h"


@implementation Company
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.companyName forKey:@"companyName"];
    [aCoder encodeObject:self.companyLogo forKey:@"companyLogo"];
    [aCoder encodeObject:self.companyProducts forKey:@"companyProducts"];
    [aCoder encodeObject:self.companyStockPrices forKey:@"companyStockPrices"];
    [aCoder encodeObject:self.companyStockCode forKey:@"companyStockCode"];
    [aCoder encodeObject:self.companyStockPrice forKey:@"companyStockPrice"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _companyName = [[aDecoder decodeObjectForKey:@"companyName"] retain];
        _companyLogo = [[aDecoder decodeObjectForKey:@"companyLogo"] retain];
        _companyProducts = [[aDecoder decodeObjectForKey:@"companyProducts"] retain];
        _companyStockCode = [[aDecoder decodeObjectForKey:@"companyStockCode"] retain];
        _companyStockPrices = [[aDecoder decodeObjectForKey:@"companyStockPrices"] retain];
        _companyStockPrice = [[aDecoder decodeObjectForKey:@"companyStockPrice"] retain];
    }
    return self;
}
@end
