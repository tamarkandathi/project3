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
    Company *company = [[Company alloc] init];
    
    company.companyName = [NSString stringWithFormat:@"%@ (default stock price Apple)",self.companyNew.text];
    company.companyLogo = @"defaultCompanyLogo.jpeg";
    company.companyStockCode = @"AAPL";
    [[DataAccessObject sharedDataAccessObject] addCompany:company];
    company.companyProducts = [[[NSMutableArray alloc]init] autorelease];
    [self.navigationController popViewControllerAnimated:YES];
    
    [company release];
}

- (void)dealloc {
    [_companyNew release];
    [_companyNewStockCode release];
    [super dealloc];
}
@end
