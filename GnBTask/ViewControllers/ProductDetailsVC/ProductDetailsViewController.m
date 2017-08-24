//
//  ProductDetailsViewController.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/18/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CoreDataHelper.h"
#import "SocialHelper.h"

@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUiData];
}

-(void) setUiData
{
    self.productDescription.text = self.product.productDescription;
    self.productPrice.text = [NSString stringWithFormat:@"Price : %@ LE",self.product.price];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:self.product.image.url]];
    
    if ([CoreDataHelper isInCart:self.product.id]) {
        [self.addToMyListButton setTitle:@"On My List" forState:UIControlStateNormal];
    }
    else
    {
        [self.addToMyListButton setTitle:@"Add to my list" forState:UIControlStateNormal];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)shareOnTwitter:(id)sender
{
    [SocialHelper shareToTwitterWithDescription:self.product.productDescription andImage:self.productImage.image];
}

-(IBAction)addToMyList:(id)sender
{
    if ([CoreDataHelper isInCart:self.product.id]) {
        [CoreDataHelper deleteProduct:self.product.id];
        [self.addToMyListButton setTitle:@"Add to my list" forState:UIControlStateNormal];
    }
    else
    {
        [CoreDataHelper addToProduct:self.product.id];
        [self.addToMyListButton setTitle:@"On My List" forState:UIControlStateNormal];
    }
    
}

@end
