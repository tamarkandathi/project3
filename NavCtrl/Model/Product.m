//
//  Product.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        [self setProductName:[coder decodeObjectForKey:@"prodName"]];
        [self setProductLogo:[coder decodeObjectForKey:@"prodLogo"]];
        [self setProductUrl: [coder decodeObjectForKey:@"prodUrl"]];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.productName forKey:@"prodName"];
    [aCoder encodeObject:self.productLogo forKey:@"prodLogo"];
    [aCoder encodeObject:self.productUrl forKey:@"prodUrl"];

}

@end
