//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ChildViewController.h"
#import "WebViewController.h"
#import "Company.h"
#import "Product.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
        //Do Whatever You want on Began of Gesture
        
        //Company *userSelectedCompany = [[Company alloc]init];
        UITableView *tableView = (UITableView *)self.view;
        CGPoint point = [sender locationInView:self.view];
        self.editPosition = [tableView indexPathForRowAtPoint:point];
        EditProductViewController *editProdViewController = [[EditProductViewController alloc] initWithNibName:@"EditProductViewController" bundle:nil];
        editProdViewController.editPosition = self.editPosition;
        editProdViewController.products = self.products;
        
        [self.navigationController pushViewController:editProdViewController animated:YES];
    }
    
    
}

-(void)addProduct {

    AddProductViewController *addProdViewController = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    addProdViewController.compNew = self.compNew;
    addProdViewController.compNew.companyProducts = self.compNew.companyProducts;
    [self.navigationController pushViewController:addProdViewController animated:YES];
    [NSMutableArray new];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
   return [self.compNew.companyProducts count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    

    Product *p = [self.compNew.companyProducts objectAtIndex:[indexPath row]];
    cell.textLabel.text = p.productName;
    [[cell imageView] setImage:[UIImage imageNamed:p.productLogo]];
    
    
    //4. show logo for each product

    
    return cell;
}


// Override to support conditional editing of the table view.
 
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.compNew.companyProducts removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView beginUpdates];
        [tableView endUpdates];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{

    id buffer = [self.compNew.companyProducts objectAtIndex:fromIndexPath.row];
    [self.compNew.companyProducts removeObjectAtIndex:fromIndexPath.row];
    [self.compNew.companyProducts insertObject:buffer atIndex:toIndexPath.row];

}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    WebViewController *detailViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];

    // Pass the selected object to the new view controller.
    


    Product *p = [self.compNew.companyProducts objectAtIndex:[indexPath row]];
    [detailViewController setUrl:p.productUrl];
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 


@end
