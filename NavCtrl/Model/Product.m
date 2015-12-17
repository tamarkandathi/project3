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
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.productName forKey:@"productName"];
    [aCoder encodeObject:self.productLogo forKey:@"productLogo"];
    [aCoder encodeObject:self.productUrl forKey:@"productUrl"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _productName = [[aDecoder decodeObjectForKey:@"productName"] retain];
        _productLogo = [[aDecoder decodeObjectForKey:@"productLogo"] retain];
        _productUrl = [[aDecoder decodeObjectForKey:@"productUrl"] retain];
    }
    return self;
}
@end
