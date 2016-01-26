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
    selectedProduct.ID = self.productID;
    [[DataAccessObject sharedDataAccessObject] editProduct:selectedProduct atIndexPath:self.indexPath forCompany:self.company];
    [self.navigationController popViewControllerAnimated:YES];
    [selectedProduct release];
}

- (void)dealloc {
    [_editedProduct release];
    [super dealloc];
}
@end




