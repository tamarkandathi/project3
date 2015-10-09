//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@class ChildViewController;

@interface qcdDemoViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *companyLogos;

@property (nonatomic, retain) IBOutlet  ChildViewController *childVC;
@property (nonatomic, retain) DataAccessObject *dao;

@end
