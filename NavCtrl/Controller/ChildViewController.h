//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataAccessObject;
@class Company;
@class Product;
@class WebViewController;
@class AddProductViewController;

@interface ChildViewController : UITableViewController
@property (retain, nonatomic) Company *company;

@end
