//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface ChildViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *apple_products;
@property (nonatomic, retain) NSMutableArray *samsung_products;
@property (nonatomic, retain) NSMutableArray *moto_products;
@property (nonatomic, retain) NSMutableArray *htc_products;


@property (nonatomic, retain) NSMutableArray *appleUrls;
@property (nonatomic, retain) NSMutableArray *motorolaUrls;
@property (nonatomic, retain) NSMutableArray *htcUrls;
@property (nonatomic, retain) NSMutableArray *samsungUrls;
@end
