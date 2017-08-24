//
//  ProductsViewController.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/18/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicCollectionLayout.h"

@interface ProductsViewController : UIViewController<DynamicCollectionLayoutDelegate>

@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, weak) IBOutlet UICollectionView * myCollectionView;

@end
