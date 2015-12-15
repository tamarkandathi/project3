//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"
#import "DataAccessObject.h"
#import "Company.h"
#import "Product.h"
@implementation EditProductViewController

- (IBAction)editProductName:(id)sender {
    Product *selectedProduct = [[Product alloc] init];
    selectedProduct.productName = self.editedProduct.text;
    selectedProduct.productLogo = @"defaultProductLogo.png";
    selectedProduct.productUrl = kGenericUrl;
    [[DataAccessObject sharedDataAccessObject] editProduct:selectedProduct atIndex:self.indexPath fromCompany:self.company];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_editedProduct release];
    [super dealloc];
}
@end




