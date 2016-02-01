//
//  Company.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Company.h"


@implementation Company

-(void)dealloc{
    [_companyName release];
    _companyName = nil;
    [_companyLogo release];
    _companyLogo = nil;
    [_companyProducts removeAllObjects];
    [_companyProducts release];
    
    [_companyStockCode release];
    _companyStockCode = nil;
    
    [_companyStockPrice release];
    _companyStockPrice = nil;
    
    [super dealloc];
    
}

@end
