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
#import "ContentCell.h"

@interface ChildViewController ()
@property (nonatomic) BOOL beingDeleted;
@property (nonatomic) UIBarButtonItem *deleteButton;
@end

@implementation ChildViewController

-(instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(768, 80);
    layout.minimumLineSpacing = 2.0;
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
    self.clearsSelectionOnViewWillAppear = NO;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addProduct)];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.deleteButton, addButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2.0;
    [self.collectionView addGestureRecognizer:longPress];
    [longPress release];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
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

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender {
 if (sender.state == UIGestureRecognizerStateBegan){
     CGPoint point = [sender locationInView:self.collectionView];
     NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
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

#pragma mark - Collection view data source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.company.companyProducts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCell" forIndexPath:indexPath];
    Product *product = [self.company.companyProducts objectAtIndex:[indexPath row]];
    cell.nameLabel.text = product.productName;
    cell.imageView.image = [UIImage imageNamed:product.productLogo];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Product *product = [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] objectAtIndex:indexPath.row];
    if (self.beingDeleted) {
        [[[DataAccessObject sharedDataAccessObject] getAllProductsForCompany:self.company] removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
        [UIView animateWithDuration:0.5 animations:^{
            [self.collectionView deleteItemsAtIndexPaths:indexPaths];
            [self.collectionView reloadData];
        }];
    }else {
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [webVC setUrl:product.productUrl];
    [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
