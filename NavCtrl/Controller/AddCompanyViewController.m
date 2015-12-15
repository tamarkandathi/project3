//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"
#import "DataAccessObject.h"
#import "Company.h"


@implementation AddCompanyViewController

- (IBAction)addNewCompany:(id)sender {
    Company *addedCompany = [[Company alloc] init];
    
    addedCompany.companyName = self.companyNew.text;
    addedCompany.companyLogo = @"defaultCompanyLogo.jpeg";
    
    if ([self.companyNewStockCode.text isEqualToString:@""]) {
        addedCompany.companyStockCode = @"N/A";
    } else {
        addedCompany.companyStockCode = self.companyNewStockCode.text;
    }
    [[DataAccessObject sharedDataAccessObject].companies addObject:addedCompany];
    addedCompany.companyProducts = [[NSMutableArray alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_companyNew release];
    [_companyNewStockCode release];
    [super dealloc];
}
@end
