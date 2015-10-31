//
//  EditCompanyViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/14/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"

@interface EditCompanyViewController ()

@end

@implementation EditCompanyViewController

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

- (IBAction)editCompanyName:(id)sender {

    NSLog(@"%ld",(long)self.editPosition.row);
    
    Company *userSelectedCompany = [self.companies objectAtIndex:self.editPosition.row];
    userSelectedCompany.companyName = self.userInput.text;
    self.dao = [DataAccessObject sharedInstance]; 
    [self.dao save];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
