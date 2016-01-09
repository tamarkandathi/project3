//
//  EditCompanyViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"
#import "DataAccessObject.h"
#import "Company.h"

@implementation EditCompanyViewController

- (IBAction)editCompanyName:(id)sender {
    Company *selectedCompany = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:self.indexPath.row];
    selectedCompany.companyName = [NSString stringWithFormat:@"%@ (default stock price Apple)",self.editedCompany.text];
    selectedCompany.companyLogo = @"defaultCompanyLogo.jpeg";
    selectedCompany.companyStockCode = @"AAPL";
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc {
    [_editedCompanyStockCode release];
    [super dealloc];
}
@end
