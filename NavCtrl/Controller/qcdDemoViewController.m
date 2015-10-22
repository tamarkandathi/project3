//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"

@implementation qcdDemoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getStockPricesFromYahoo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    //self.companyStockCodes = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addCompany)];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.editButtonItem, addButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
    
    
    
    //singleton - READ ABOUT THIS !!!!!!!!!
    static dispatch_once_t dispatch = 0;
    dispatch_once (&dispatch, ^{
        self.dao = [[DataAccessObject alloc] init];
    });
    
    [self.dao loadData];
    
    self.companies = self.dao.companies;
    
    self.title = @"Mobile device makers";
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2.0; //seconds

    [self.tableView addGestureRecognizer:longPress];
    [longPress release];
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
        
        UITableView *tableView = (UITableView *)self.view;
        CGPoint point = [sender locationInView:self.view];
        self.editPosition = [tableView indexPathForRowAtPoint:point];
        EditCompanyViewController *editCompViewController = [[EditCompanyViewController alloc] initWithNibName:@"EditCompanyViewController" bundle:nil];
        editCompViewController.editPosition = self.editPosition;
        editCompViewController.companies = self.companies;
        
        [self.navigationController pushViewController:editCompViewController animated:YES];
    }
    
    
}

#pragma mark - Table view data source
-(void)addCompany {
    
    AddCompanyViewController *addCompViewController = [[AddCompanyViewController alloc] initWithNibName:@"AddCompanyViewController" bundle:nil];
    
    addCompViewController.companies = self.companies;
    [self.navigationController pushViewController:addCompViewController animated:YES];
    
}

-(void) getStockPricesFromYahoo {
    
    NSString *stockCodesURL = @"";
    
    for(int i = 0;i < [self.companies count];i++) {
        Company *company = [self.companies objectAtIndex:i];
        stockCodesURL = [stockCodesURL stringByAppendingString:company.companyStockCode];
        
        if (i != [self.companies count]-1) {
            stockCodesURL = [stockCodesURL stringByAppendingString:@"+"];
        }
    }
    
    stockCodesURL = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a",stockCodesURL];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stockCodesURL]
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error){
        if (!error) {
            NSLog(@"Perfect! \n\n");
            NSString *stockString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            self.companyStockPrices = (NSMutableArray*)[stockString componentsSeparatedByString:@"\n"];

            [self.companyStockPrices removeLastObject];
            NSLog(@"%@", self.companyStockPrices);
            self.dao.companyStockPrices = self.companyStockPrices;
            [self.dao updateStockPrices];
        
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    
    
    });
                    }
         }]resume];

    
    
}
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
    return [self.companies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *company = [self.companies objectAtIndex:[indexPath row]];
    //NSString *
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", company.companyName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",company.companyStockPrice];
    
    
    //4. show the logo for each company : set images for each row based on the company in that row
    [[cell imageView] setImage:[UIImage imageNamed:company.companyLogo]];    
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.companies removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

//       [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id buffer = [self.companies objectAtIndex:fromIndexPath.row];
    [self.companies removeObjectAtIndex:fromIndexPath.row];
    [self.companies insertObject:buffer atIndex:toIndexPath.row];
    
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
    Company *company = [self.companies objectAtIndex:indexPath.row];
    
    [self.childVC setProducts:company.companyProducts];
    
    //NSString *companyName = company.companyName;
    
    self.childVC.title = company.companyName;
    
    self.childVC.compNew = company;
    
    [self.navigationController
     pushViewController:self.childVC
     animated:YES];
}
 


@end
