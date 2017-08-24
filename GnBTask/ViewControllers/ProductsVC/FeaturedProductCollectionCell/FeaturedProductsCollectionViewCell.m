//
//  FeaturedProductsCollectionViewCell.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "FeaturedProductsCollectionViewCell.h"
#import "DynamicCollectionLayout.h"

@implementation FeaturedProductsCollectionViewCell

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    DynamcLayoutAttributes * attributes = (DynamcLayoutAttributes *)layoutAttributes;
    self.imageViewHeight.constant = attributes.photoHeight;
}

@end
