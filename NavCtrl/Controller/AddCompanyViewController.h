//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataAccessObject;
@class Company;

@interface AddCompanyViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *companyNewStockCode;
@property (retain, nonatomic) IBOutlet UITextField *companyNew;

- (IBAction)addNewCompany:(id)sender;

@end
