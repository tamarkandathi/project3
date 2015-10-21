//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"
#import "qcdDemoViewController.h"


@interface AddCompanyViewController : UIViewController

@property (nonatomic,retain) IBOutlet UITextField *userInput;
@property (nonatomic, retain) IBOutlet UILabel *companyNew;
@property (nonatomic,strong) NSMutableArray *companies;

- (IBAction)addToCompanies:(id)sender;

@end
