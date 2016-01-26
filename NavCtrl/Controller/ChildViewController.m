
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
    longPress.minimumPressDuration = 2.0;
    [self.tableView addGestureRecognizer:longPress];
    [buttons release];
    [longPress release];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


-(void)handleLongPress:(UILongPressGestureRecognizer*)sender {
   if (sender.state == UIGestureRecognizerStateBegan){
        UITableView *tableView = (UITableView *)self.view;
        CGPoint point = [sender locationInView:tableView];
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:point];
       Product *product = [self.company.companyProducts objectAtIndex:[indexPath row]];
        EditProductViewController *editProductVC = [[EditProductViewController alloc] initWithNibName:@"EditProductViewController" bundle:nil];
        editProductVC.company = self.company;
        editProductVC.indexPath = indexPath;
        editProductVC.productID = product.ID;
        [self.navigationController pushViewController:editProductVC animated:YES];
       [editProductVC release];
    }
    
    
}

-(void)addProduct {

    AddProductViewController *addProductVC = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    addProductVC.company = self.company;
    [self.navigationController pushViewController:addProductVC animated:YES];
    [addProductVC release];
    
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    Product *product = [self.company.companyProducts objectAtIndex:[indexPath row]];
    cell.textLabel.text = product.productName;
    
    UIImage *logo = [UIImage imageNamed:product.productLogo];
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
        Product *product = [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] objectAtIndex:indexPath.row];
        [[DataAccessObject sharedDataAccessObject] deleteProduct: product atIndexPath:indexPath forCompany:self.company];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Product *prodA = [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] objectAtIndex:fromIndexPath.row];
    Product *prodB = [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] objectAtIndex:toIndexPath.row];
    [prodA retain];
    [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] removeObjectAtIndex:fromIndexPath.row];
    [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] insertObject:prodA atIndex:toIndexPath.row];
    [[DataAccessObject sharedDataAccessObject] swapProducts:prodA :prodB];
    [prodA release];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    NSMutableArray *productsTemp = [[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company];
    Product *product = [productsTemp objectAtIndex:indexPath.row];
    [webVC setUrl:product.productUrl];
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC release];
}
 


@end
