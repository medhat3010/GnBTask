//
//  ProductsViewController.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/18/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "ProductsViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "WebAPIHandler.h"
#import "Product.h"
#import "ProductTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductDetailsViewController.h"
#import "FeaturedProductsCollectionViewCell.h"
#import "SVPullToRefresh.h"
#import "CoreDataHelper.h"

@interface ProductsViewController ()
{
    NSMutableArray * productsArray;
    NSInteger pageIndex;
}

@end

@implementation ProductsViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    productsArray = [[NSMutableArray alloc] init];
    
    pageIndex = 1;
    
    [self getProducts];
    
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        [self getProducts];
    }];

    
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 44.0;
    
    if ([self.myCollectionView.collectionViewLayout isKindOfClass:[DynamicCollectionLayout class]]) {
        ((DynamicCollectionLayout *)self.myCollectionView.collectionViewLayout).delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getProducts
{
    if (pageIndex == 1) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [WebAPIHandler getProductsWithCount:10 andfrom:pageIndex compleiton:^(id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSError *error;
        [productsArray addObjectsFromArray:[Product arrayOfModelsFromData:data error:&error]];
        [self.myTableView reloadData];
        [self.myCollectionView reloadData];
        pageIndex += 10;
        [self.myTableView.infiniteScrollingView stopAnimating];

    } andfailureBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return productsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell" forIndexPath:indexPath];
    
    Product * product = [[Product alloc] init];
    product = productsArray[indexPath.row];
    
    cell.productDescription.text = product.productDescription;
    [cell.productDescription sizeToFit];
    cell.productPrice.text = [NSString stringWithFormat:@"Price : %@ LE",product.price];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:product.image.url]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([CoreDataHelper isInCart:product.id]) {
        [cell.addToMyListButton setTitle:@"On My List" forState:UIControlStateNormal];
    }
    else
    {
        [cell.addToMyListButton setTitle:@"Add to my list" forState:UIControlStateNormal];
    }
    cell.addToMyListButton.tag = indexPath.row;
    [cell.addToMyListButton addTarget:self action:@selector(addToMyList:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product * product = [[Product alloc] init];
    product = productsArray[indexPath.row];
    
    ProductDetailsViewController * productDetailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailsViewController"];
    productDetailsViewController.product = product;
    [self.navigationController pushViewController:productDetailsViewController animated:YES];
}
-(void) addToMyList:(UIButton*)sender
{
    Product * product = [[Product alloc] init];
    product = productsArray[sender.tag];
    
    if ([CoreDataHelper isInCart:product.id]) {
        [CoreDataHelper deleteProduct:product.id];
        [self.myTableView reloadData];
    }
    else
    {
        [CoreDataHelper addToProduct:product.id];
        [self.myTableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - CollectionView Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (productsArray.count < 8) {
        return productsArray.count;
    }
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Product * product = [[Product alloc] init];
    product = productsArray[indexPath.row];
    
    FeaturedProductsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FeaturedProductsCollectionViewCell" forIndexPath:indexPath];
    cell.productDescription.text = product.productDescription;
    cell.productPrice.text = [NSString stringWithFormat:@"Price : %@ LE",product.price];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:product.image.url]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView heightForPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    Product * product = [[Product alloc] init];
    product = productsArray[indexPath.row];

    return CGSizeMake([product.image.width floatValue], [product.image.height floatValue]);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView heightForTextAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat annotationPadding = 4;
    CGFloat annotationHeaderHeight = 17;
    Product * product = [[Product alloc] init];
    product = productsArray[indexPath.row];
    UIFont * font = [UIFont systemFontOfSize:10];
    CGFloat commentHeight = [self heightForLabelWithFont:font andWidth:150 andText:product.productDescription];
    
    CGFloat height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding;
    return height;
}

-(CGFloat) heightForLabelWithFont:(UIFont *) font andWidth:(CGFloat) width andText:(NSString *) text
{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return ceil(textRect.size.height);
}

@end
