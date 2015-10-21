//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *userInput;
- (IBAction)editProductName:(id)sender;
@property (retain, nonatomic) NSIndexPath *editPosition;
@property (nonatomic, strong) NSMutableArray *products;


@end
