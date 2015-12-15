//
//  AddProductViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"
#import "DataAccessObject.h"
#import "Product.h"
#import "Company.h"

@implementation AddProductViewController

- (IBAction)addNewProduct:(id)sender {
    
    Product *addedProduct = [[Product alloc] init];
    addedProduct.productName = self.productNew.text;
    addedProduct.productLogo = @"defaultProdLogo.png";
    
    [[DataAccessObject sharedDataAccessObject] addNewProduct:addedProduct toCompany:self.company];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_productNew release];
    [super dealloc];
}

@end
