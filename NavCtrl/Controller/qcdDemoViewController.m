//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//
#import "EditCompanyViewController.h"
#import "qcdDemoViewController.h"
#import "ChildViewController.h"
#import "AddCompanyViewController.h"
#import "DataAccessObject.h"
#import "Company.h"
#import "Product.h"


@implementation qcdDemoViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:downloadStockPricesNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DataAccessObject sharedDataAccessObject] retrieveData];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addCompany)];
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.editButtonItem, addButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
    self.title = @"Mobile device makers";
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2.0; //seconds
    
    [self.tableView addGestureRecognizer:longPress];
    [buttons release];
    [longPress release];
}
-(void) reloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[DataAccessObject sharedDataAccessObject] downloadStockPrices];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark Helper methods
-(void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan){
        CGPoint point = [sender locationInView:self.view];
        self.indexPath = [self.tableView indexPathForRowAtPoint:point];
        EditCompanyViewController *editCompVC = [[EditCompanyViewController alloc] initWithNibName:@"EditCompanyViewController" bundle:nil];
        editCompVC.indexPath = self.indexPath;
        [self.navigationController pushViewController:editCompVC animated:YES];
        [editCompVC release];
    }
}
-(void)addCompany {
    AddCompanyViewController *addCompVC = [[AddCompanyViewController alloc] initWithNibName:@"AddCompanyViewController" bundle:nil];
    [self.navigationController pushViewController:addCompVC animated:YES];
    [addCompVC release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataAccessObject sharedDataAccessObject].companies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    Company *company = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:[indexPath row]];
    cell.textLabel.text = company.companyName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",company.companyStockPrice];
    UIImage *logo = [UIImage imageNamed:company.companyLogo];
    [[cell imageView] setImage: logo];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Company *company = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:[indexPath row]];
        [[DataAccessObject sharedDataAccessObject] deleteCompany:company];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{    
    Company * compA = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:fromIndexPath.row];
    Company *compB = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:toIndexPath.row];
    [compA retain];
    [[DataAccessObject sharedDataAccessObject] swapCompanies:compA :compB];
    [[DataAccessObject sharedDataAccessObject].companies removeObjectAtIndex:fromIndexPath.row];
    [[DataAccessObject sharedDataAccessObject].companies insertObject:compA atIndex:toIndexPath.row];
    [compA release];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    Company *selectedCompany = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:indexPath.row];
    self.childVC.title = selectedCompany.companyName;
    self.childVC.company = selectedCompany;
    [self.navigationController pushViewController:self.childVC animated:YES];
}
-(void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:downloadStockPricesNotification object:nil];
}
@end
