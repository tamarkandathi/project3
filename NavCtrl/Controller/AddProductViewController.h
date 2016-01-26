//
//  AddProductViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataAccessObject;
@class qcdDemoViewController;
@class ChildViewController;
@class Company;
@interface AddProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *productNew;
@property (retain,nonatomic) Company *company;
- (IBAction)addNewProduct:(id)sender;

@end
