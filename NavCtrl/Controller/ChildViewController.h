//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductViewController.h"
#import "Company.h"
#import "EditProductViewController.h"

@class WebViewController;

@interface ChildViewController : UITableViewController


@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, strong) Company *compNew;
@property (nonatomic,retain) NSIndexPath *editPosition;
@end
