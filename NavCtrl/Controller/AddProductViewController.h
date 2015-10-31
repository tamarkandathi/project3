//
//  AddProductViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildViewController.h"
#import "qcdDemoViewController.h"
#import "DataAccessObject.h"
@interface AddProductViewController : UIViewController


@property (retain, nonatomic) IBOutlet UILabel *addProdLabel;
@property (nonatomic,strong) NSMutableArray *products;
@property (retain, nonatomic) IBOutlet UITextField *userInput;
@property (nonatomic,strong) Company *compNew;
@property (nonatomic, retain) DataAccessObject *dao;

- (IBAction)add:(id)sender;

@end
