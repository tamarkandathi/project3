//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//
#import "EditProductViewController.h"
#import "DataAccessObject.h"
#import "AddProductViewController.h"
#import "ChildViewController.h"
#import "WebViewController.h"
#import "Company.h"
#import "Product.h"

@implementation ChildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addProduct)];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.editButtonItem, addButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2.0; //seconds
    //    longPress.delegate = self;
    [self.tableView addGestureRecognizer:longPress];
    [longPress release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        UITableView *tableView = (UITableView *)self.view;
        CGPoint point = [sender locationInView:tableView];
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:point];
        EditProductViewController *editProductVC = [[EditProductViewController alloc] initWithNibName:@"EditProductViewController" bundle:nil];
        editProductVC.company = self.company;
        editProductVC.indexPath = indexPath;
        [self.navigationController pushViewController:editProductVC animated:YES];
    }
}

-(void)addProduct {

    AddProductViewController *addProductVC = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    addProductVC.company = self.company;
    [self.navigationController pushViewController:addProductVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.company.companyProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Product *product = [self.company.companyProducts objectAtIndex:[indexPath row]];
    cell.textLabel.text = product.productName;
    [[cell imageView] setImage:[UIImage imageNamed:product.productLogo]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company ] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id buffer = [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] objectAtIndex:fromIndexPath.row];
    [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] removeObjectAtIndex:fromIndexPath.row];
    [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] insertObject:buffer atIndex:toIndexPath.row];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    NSMutableArray *productsTemp = [[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company];
    Product *product = [productsTemp objectAtIndex:indexPath.row];
    [webVC setUrl:product.productUrl];
    [self.navigationController pushViewController:webVC animated:YES];
}
 


@end
