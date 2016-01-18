//
//  Product.h
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Company;

@interface Product : NSObject 
@property (retain, nonatomic) NSString *productName;
@property (retain,nonatomic) NSString *productLogo;
@property(retain, nonatomic) NSString *productUrl;
//@property (retain, nonatomic) Company *productCompany;
@end
