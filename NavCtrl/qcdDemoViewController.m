//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"

@interface qcdDemoViewController ()

@end

@implementation qcdDemoViewController

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
    
    
    //2. add two more companies
    self.companyList = [[NSMutableArray alloc]
                       initWithObjects:@"Apple mobile devices",
                       @"Samsung mobile devices",@"Motorola mobile devices",@"HTC mobile devices", nil];
    NSLog(@"company list %@",self.companyList);
    
    self.title = @"Mobile device makers";
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    
    //4. show the logo for each company : set images for each row based on the company in that row
   

    if ([cell.textLabel.text isEqualToString:@"Apple mobile devices"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"AppleLogo.png"]];
    } else if ([cell.textLabel.text isEqualToString:@"Samsung mobile devices"]){
        [[cell imageView] setImage:[UIImage imageNamed:@"SamsungLogo.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Motorola mobile devices"]){
        [[cell imageView] setImage:[UIImage imageNamed:@"MotorolaLogo.jpeg"]];
    } else {
        [[cell imageView] setImage:[UIImage imageNamed:@"HTCLogo.jpeg" ]];
    }
        
    
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
        
        [self.companyList removeObjectAtIndex: indexPath.row];
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
    id buffer = [self.companyList objectAtIndex:fromIndexPath.row];
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:buffer atIndex:toIndexPath.row];
    
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

    self.childVC.title = [NSString stringWithFormat:@"%@",[self.companyList objectAtIndex:indexPath.row]];
    
    [self.navigationController
     pushViewController:self.childVC
     animated:YES];
    

}
 


@end
