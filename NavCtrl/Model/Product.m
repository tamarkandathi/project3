//
//  Product.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

NSString *kGenericUrl = @"http://turntotech.io/";

@implementation Product

-(void)dealloc{
    [_productName release];
    _productName = nil;
    [_productLogo release];
    _productLogo = nil;
    
    [_productUrl release];
    _productUrl = nil;
    
    [super dealloc];
}

@end
