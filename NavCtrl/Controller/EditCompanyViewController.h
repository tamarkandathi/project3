//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface EditCompanyViewController : UIViewController

@property (nonatomic,retain) IBOutlet UITextField *userInput;

@property (nonatomic,strong) NSMutableArray *companies;
@property (nonatomic, retain) NSIndexPath *editPosition;
- (IBAction)editCompanyName:(id)sender;


@end
