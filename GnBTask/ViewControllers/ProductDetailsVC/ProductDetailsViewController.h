//
//  ProductDetailsViewController.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/18/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailsViewController : UIViewController

@property (nonatomic, strong) Product *product;

@property (nonatomic, weak) IBOutlet UITextView *productDescription;
@property (nonatomic, weak) IBOutlet UIImageView *productImage;
@property (nonatomic, weak) IBOutlet UILabel *productPrice;
@property (nonatomic, weak) IBOutlet UIButton *addToMyListButton;


@end
