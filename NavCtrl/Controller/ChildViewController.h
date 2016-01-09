//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qcdDemoViewController.h"
@class DataAccessObject;
@class Company;
@class Product;
@class WebViewController;
@class AddProductViewController;

@interface ChildViewController : UICollectionViewController
@property (strong, nonatomic) Company *company;
@end
