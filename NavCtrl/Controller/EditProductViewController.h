//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "DataAccessObject.h"

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *userInput;

@property (retain, nonatomic) NSIndexPath *editPosition;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, retain) DataAccessObject *dao;

- (IBAction)editProductName:(id)sender;

@end
