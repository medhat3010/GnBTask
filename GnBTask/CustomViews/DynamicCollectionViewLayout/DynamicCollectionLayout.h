//
//  DynamicCollectionLayout.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DynamcLayoutAttributes : UICollectionViewLayoutAttributes

@property CGFloat photoHeight;

@end


@class DynamicCollectionLayout;
@protocol DynamicCollectionLayoutDelegate <NSObject>

-(CGSize) collectionView:(UICollectionView *) collectionView heightForPhotoAtIndexPath:(NSIndexPath *) indexPath;
-(CGFloat) collectionView:(UICollectionView *) collectionView heightForTextAtIndexPath:(NSIndexPath *) indexPath;

@end

@interface DynamicCollectionLayout : UICollectionViewLayout

@property(nonatomic,weak) id <DynamicCollectionLayoutDelegate> delegate;


@end
