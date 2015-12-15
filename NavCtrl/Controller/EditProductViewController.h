//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataAccessObject;
@class Company;

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *editedProduct;
@property (retain, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) Company *company;

- (IBAction)editProductName:(id)sender;

@end
