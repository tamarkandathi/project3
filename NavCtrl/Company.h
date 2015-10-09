//
//  Company.h
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface Company : UIViewController

@property (retain,nonatomic) NSMutableArray *companyProducts;
@property (retain, nonatomic) NSString *companyName;
@property (retain, nonatomic) NSString *companyLogo;

@end
