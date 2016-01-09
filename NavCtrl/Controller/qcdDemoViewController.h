//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataAccessObject;
@class AddCompanyViewController;
@class EditCompanyViewController;
@class ChildViewController;

@interface qcdDemoViewController : UICollectionViewController
@property (retain, nonatomic) IBOutlet  ChildViewController *childVC;
@property (retain, nonatomic) NSIndexPath *indexPath;
@end
