//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "AddCompanyViewController.h"
#import "EditCompanyViewController.h"

@class ChildViewController;

@interface qcdDemoViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *companyLogos;
//@property (retain, nonatomic) NSMutableArray *companyStockCodes;
@property (nonatomic, retain) NSMutableArray *companyStockPrices;
//@property double companyStockPrice;
@property (nonatomic, retain) IBOutlet  ChildViewController *childVC;
@property (nonatomic, retain) DataAccessObject *dao;
@property (nonatomic, retain) NSIndexPath *editPosition;

@end
