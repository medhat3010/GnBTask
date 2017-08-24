//
//  FeaturedProductsCollectionViewCell.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedProductsCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *productDescription;
@property (nonatomic, weak) IBOutlet UIImageView *productImage;
@property (nonatomic, weak) IBOutlet UILabel *productPrice;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeight;

@end
