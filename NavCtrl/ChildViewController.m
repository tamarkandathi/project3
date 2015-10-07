//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ChildViewController.h"
#import "WebViewController.h"

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
    self.apple_products = [[NSMutableArray alloc ]
                     initWithObjects:@"iPad", @"iPod Touch",@"iPhone", nil];
    self.samsung_products = [[NSMutableArray alloc ]
                     initWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    self.moto_products = [[NSMutableArray alloc]
                     initWithObjects:@"Droid Turbo",@"Droid 3",@"Droid MAX", nil];
    self.htc_products = [[NSMutableArray alloc]
                         initWithObjects:@"Droid DNA",@"One M8",@"Desire 816", nil];
    
    // URLS
    self.appleUrls = [NSMutableArray arrayWithObjects:@"https://www.apple.com/ipad/",@"https://www.apple.com/ipod/",@"https://www.apple.com/iphone/", nil];
    
    self.samsungUrls = [NSMutableArray arrayWithObjects:@"http://www.samsung.com/us/mobile/cell-phones/SM-G928VZDAVZW",@"http://www.samsung.com/us/mobile/cell-phones/all-products?filter=galaxy-note",@"http://www.samsung.com/us/mobile/galaxy-tab/", nil];
    self.motorolaUrls = [NSMutableArray arrayWithObjects:@"https://www.motorola.com/us/smartphones/droid-turbo/droid-turbo-pdp.html",@"https://www.motorola.com/us/DROID-3-BY-MOTOROLA/73138.html",@"https://www.motorola.com/us/smartphones/droid-maxx/m-droid-maxx.html", nil];
    self.htcUrls = [NSMutableArray arrayWithObjects:@"https://www.htc.com/us/smartphones/droid-dna-by-htc/",@"https://www.htc.com/us/smartphones/htc-one-m8/",@"https://www.htc.com/us/smartphones/htc-desire-816/", nil];
    
    
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
    
        if ([self.title isEqualToString:@"Apple mobile devices"]) {
            return [self.apple_products count];
        }
        else if ([self.title isEqualToString:@"Samsung mobile devices"]){
           return [self.samsung_products count];
        }
        else if ([self.title isEqualToString: @"Motorola mobile devices"]) {
           return [self.moto_products count];
        }
        else{
           return [self.htc_products count];
        }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        cell.textLabel.text = [self.apple_products objectAtIndex:
                               [indexPath row]];
    }
    else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        cell.textLabel.text = [self.samsung_products objectAtIndex:
                               [indexPath row]];
    }
    else if ([self.title isEqualToString: @"Motorola mobile devices"]) {
        cell.textLabel.text = [self.moto_products objectAtIndex:
                               [indexPath row]];
    }
    else{
        cell.textLabel.text = [self.htc_products objectAtIndex:
                               [indexPath row]];
    }
    
    
    
    //4. show logo for each product
    if ([cell.textLabel.text isEqualToString:@"iPad"] ) {
        [[cell imageView] setImage:[UIImage imageNamed:@"iPad.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"iPod Touch"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"iPodTouch.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"iPhone"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"iPhone.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Galaxy S4"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"GalaxyS4.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Galaxy Tab"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"GalaxyTab.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Galaxy Note"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"GalaxyNote.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Droid Turbo"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"MotorolaDroidTurbo.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Droid MAX"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"MotorolaDroidMAX.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Droid 3"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"MotorolaDroid3.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Droid DNA"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"HTCDroidDNA.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"One M8"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"HTCOneM8.jpeg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Desire 816"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"HTCDesire816.jpeg"]];
    }
        
    
    
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
        if ([self.title isEqualToString:@"Apple mobile devices"]) {
            [self.apple_products removeObjectAtIndex:indexPath.row];
            [self.appleUrls removeObjectAtIndex:indexPath.row];
        }
        else if ([self.title isEqualToString:@"Samsung mobile devices"]){
            [self.samsung_products removeObjectAtIndex:indexPath.row];
            [self.samsungUrls removeObjectAtIndex:indexPath.row];
        }
        else if ([self.title isEqualToString: @"Motorola mobile devices"]) {
            [self.moto_products removeObjectAtIndex:indexPath.row];
            [self.motorolaUrls removeObjectAtIndex:indexPath.row];
        }
        else{
            [self.htc_products removeObjectAtIndex:indexPath.row];
            [self.htcUrls removeObjectAtIndex:indexPath.row];
        }
        
        
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
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        id buffer = [self.apple_products objectAtIndex:fromIndexPath.row];
        [self.apple_products removeObjectAtIndex:fromIndexPath.row];
        [self.apple_products insertObject:buffer atIndex:toIndexPath.row];
    }
    else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        id buffer = [self.samsung_products objectAtIndex:fromIndexPath.row];
        [self.samsung_products removeObjectAtIndex:fromIndexPath.row];
        [self.samsung_products insertObject:buffer atIndex:toIndexPath.row];
    }
    else if ([self.title isEqualToString: @"Motorola mobile devices"]) {
        id buffer = [self.moto_products objectAtIndex:fromIndexPath.row];
        [self.moto_products removeObjectAtIndex:fromIndexPath.row];
        [self.moto_products insertObject:buffer atIndex:toIndexPath.row];
    }
    else{
        id buffer = [self.htc_products objectAtIndex:fromIndexPath.row];
        [self.htc_products removeObjectAtIndex:fromIndexPath.row];
        [self.htc_products insertObject:buffer atIndex:toIndexPath.row];
    }

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
    
    NSString *prodOne = [self.apple_products objectAtIndex:indexPath.row];
    NSString *prodTwo = [self.samsung_products objectAtIndex:indexPath.row];
    NSString *prodThree = [self.moto_products objectAtIndex:indexPath.row];
    NSString *prodFour = [self.htc_products objectAtIndex:indexPath.row];

    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        if([prodOne isEqual:@"iPad"]){
        [detailViewController setUrl:@"https://www.apple.com/ipad/"];
        }
        if([prodOne isEqual:@"iPod Touch"]){
            [detailViewController setUrl:@"https://www.apple.com/ipod/"];
        }
        if([prodOne isEqual:@"iPhone"]){
            [detailViewController setUrl:@"https://www.apple.com/iphone/"];
        }
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
            
        if([prodTwo isEqual:@"Galaxy S4"]){
            [detailViewController setUrl:@"http://www.samsung.com/us/mobile/cell-phones/SM-G928VZDAVZW"];
        }
        if([prodTwo isEqual:@"Galaxy Note"]){
            [detailViewController setUrl:@"http://www.samsung.com/us/mobile/cell-phones/all-products?filter=galaxy-note"];
        }
        if([prodTwo isEqual:@"Galaxy Tab"]){
            [detailViewController setUrl:@"http://www.samsung.com/us/mobile/galaxy-tab/"];
        }
    } else if ([self.title isEqualToString:@"Motorola mobile devices"]) {
        if([prodThree isEqual:@"Droid Turbo"]){
            [detailViewController setUrl:@"https://www.motorola.com/us/smartphones/droid-turbo/droid-turbo-pdp.html"];
        }
        if([prodThree isEqual:@"Droid 3"]){
            [detailViewController setUrl:@"https://www.motorola.com/us/DROID-3-BY-MOTOROLA/73138.html"];
        }
        if([prodThree isEqual:@"Droid MAX"]){
            [detailViewController setUrl:@"https://www.motorola.com/us/smartphones/droid-maxx/m-droid-maxx.html"];
        }
    } else {
        if([prodFour isEqual:@"Droid DNA"]){
            [detailViewController setUrl:@"https://www.htc.com/us/smartphones/droid-dna-by-htc/"];
        }
        if([prodFour isEqual:@"One M8"]){
            [detailViewController setUrl:@"https://www.htc.com/us/smartphones/htc-one-m8/"];
        }
        if([prodFour isEqual:@"Desire 816"]){
            [detailViewController setUrl:@"https://www.htc.com/us/smartphones/htc-desire-816/"];
        }

    }


    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 


@end
