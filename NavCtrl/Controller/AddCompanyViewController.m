//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/13/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"


@implementation AddCompanyViewController

-(void)addToCompanies:(id)sender{
    
    Company *userAddedCompany = [[Company alloc] init];
    
    userAddedCompany.companyName = self.userInput.text;
    userAddedCompany.companyLogo = @"defaultCompanyLogo.jpeg";
    
    userAddedCompany.companyProducts = [[NSMutableArray alloc]init];
    [self.companies addObject:userAddedCompany];
    [self.navigationController popViewControllerAnimated:YES];
    
}

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


@end
