//
//  AddProductViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_addProdLabel release];
    [_userInput release];
    [super dealloc];
}


- (IBAction)add:(id)sender {
    
    Product *userAddedProduct = [[Product alloc] init];
    userAddedProduct.productName = self.userInput.text;
    userAddedProduct.productLogo = @"defaultProdLogo.png";
    
    [self.compNew.companyProducts addObject:userAddedProduct];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
