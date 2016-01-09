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
#import "ContentCell.h"

@interface qcdDemoViewController ()
@property (nonatomic) BOOL beingDeleted;
@property (nonatomic) UIBarButtonItem *deleteButton;
@end

@implementation qcdDemoViewController

-(instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(768, 80);
    layout.minimumLineSpacing = 2.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:downloadStockPricesNotification object:nil];
    _deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(deletePressed)];
    _beingDeleted = NO;
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ContentCell class] forCellWithReuseIdentifier:@"ContentCell"];
    [[DataAccessObject sharedDataAccessObject] retrieveData];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addCompany)];
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.deleteButton, addButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
    self.title = @"Mobile device makers";
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2.0; //seconds
    [self.collectionView addGestureRecognizer:longPress];
    [longPress release];

}
-(void) reloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
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
        self.indexPath = [self.collectionView indexPathForItemAtPoint:point];
        EditCompanyViewController *editCompVC = [[EditCompanyViewController alloc] initWithNibName:@"EditCompanyViewController" bundle:nil];
        editCompVC.indexPath = self.indexPath;
        
        [self.navigationController pushViewController:editCompVC animated:YES];
    }
}
-(void)addCompany {
    AddCompanyViewController *addCompVC = [[AddCompanyViewController alloc] initWithNibName:@"AddCompanyViewController" bundle:nil];
    [self.navigationController pushViewController:addCompVC animated:YES];
}

-(void) deletePressed {
    if (self.beingDeleted == NO) {
        [self showAlert];
        self.beingDeleted = YES;
        self.deleteButton.title = @"Done";
    } else {
    self.deleteButton.title = @"Delete";
    self.beingDeleted = NO;
    }
}

-(void) showAlert {
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"Sure about this?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.deleteButton.tintColor = [UIColor blueColor];
        self.beingDeleted = NO;
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    
    UIPopoverPresentationController *presentationController = [alert popoverPresentationController];
    presentationController.sourceView = self.collectionView;
    presentationController.sourceRect = CGRectMake((self.collectionView.frame.size.width / 2) - 80/2, 0, 80, 200);
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Collection view data source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[DataAccessObject sharedDataAccessObject].companies count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    Company *company = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:[indexPath row]];
    cell.nameLabel.text = company.companyName;
    cell.imageView.image = [UIImage imageNamed:company.companyLogo];
    cell.stockPriceLabel.text = company.companyStockPrice;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.beingDeleted == YES) {
        [[DataAccessObject sharedDataAccessObject].companies removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
        [UIView animateWithDuration:0.5 animations:^{
            [self.collectionView deleteItemsAtIndexPaths:indexPaths];
            [self.collectionView reloadData];
        }];
        
    } else {
    Company *selectedCompany = [[DataAccessObject sharedDataAccessObject].companies objectAtIndex:indexPath.row];
    self.childVC = [[ChildViewController alloc] init];
        self.childVC.title = selectedCompany.companyName;
        self.childVC.company = selectedCompany;
        [self.navigationController pushViewController:self.childVC animated:YES];
    }
}

-(void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:downloadStockPricesNotification object:nil];
}

@end
