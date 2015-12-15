//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataAccessObject;
@class Company;

@interface EditCompanyViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *editedCompanyStockCode;
@property (retain,nonatomic) IBOutlet UITextField *editedCompany;
@property (retain, nonatomic) NSIndexPath *indexPath;
- (IBAction)editCompanyName:(id)sender;

@end
