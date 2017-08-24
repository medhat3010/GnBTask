//
//  DynamicCollectionLayout.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "DynamicCollectionLayout.h"


@implementation DynamcLayoutAttributes

-(id)copyWithZone:(NSZone *)zone
{
    DynamcLayoutAttributes *copy = [super copyWithZone:zone];
    copy.photoHeight = self.photoHeight;
    return copy;
}

-(BOOL)isEqual:(id)object
{
    DynamcLayoutAttributes * attributes = object;
    
    if (attributes.photoHeight == _photoHeight) {
        return [super isEqual:object];
    }
    
    return false;
    
}

@end

@implementation DynamicCollectionLayout

    int numberOfColumns = 8;
    CGFloat cellPadding = 0.0;
    NSMutableArray<UICollectionViewLayoutAttributes *> *cache;

    CGFloat contentHeight = 0.0;
    CGFloat contentWidth = 1254;


+(Class)layoutAttributesClass
{
    return DynamcLayoutAttributes.self;
}

-(void)prepareLayout
{
    if (cache.count == 0) {
        cache = [[NSMutableArray alloc] init];
        
        CGFloat columnWidth = contentWidth / numberOfColumns;
        NSMutableArray * xOffset = [[NSMutableArray alloc] init];
        for (int i = 0; i < numberOfColumns; i++) {
            [xOffset  addObject:[NSNumber numberWithFloat:i*columnWidth]];
        }
        int column = 0;
        
        
        NSMutableArray * yOffset = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < numberOfColumns; i++) {
            [yOffset addObject:[NSNumber numberWithFloat:0]];
        }
        
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
            
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            
            CGSize imageSize = [self.delegate collectionView:self.collectionView heightForPhotoAtIndexPath:indexPath];
            
            CGFloat width = imageSize.width - cellPadding * 2;

            
            CGFloat photoHeight = imageSize.height;
            
            CGFloat annotationHeight = [self.delegate collectionView:self.collectionView heightForTextAtIndexPath:indexPath];
            
            CGFloat height = cellPadding +  photoHeight + annotationHeight + cellPadding;
            
            CGRect frame = CGRectMake([xOffset[i] floatValue], [yOffset[i] floatValue], width, height);

            CGRect insetFrame = CGRectInset(frame, cellPadding, cellPadding);
            

            DynamcLayoutAttributes *attributes = [DynamcLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.photoHeight = photoHeight;
            
            attributes.frame = insetFrame;
            [cache addObject:attributes];
            
            contentHeight = fmax(contentHeight, CGRectGetMaxY(frame));
            
            yOffset[i] = [NSNumber numberWithFloat:[yOffset[i] floatValue] + height];
            
            column = column >= (numberOfColumns - 1) ? 0 : ++column;
        }

    }
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(contentWidth, contentHeight);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[NSMutableArray alloc] init];
    
    for (UICollectionViewLayoutAttributes *attributes in cache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
    }
    return layoutAttributes;
}

@end
