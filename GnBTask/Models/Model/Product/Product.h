//
//  Product.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "Image.h"

@interface Product : JSONModel

@property (nonatomic, copy) NSString<Optional> * productDescription;
@property (nonatomic, copy) NSNumber<Optional> * id;
@property (nonatomic, copy) NSNumber<Optional> * price;
@property (nonatomic, copy) Image<Optional> *image;

@end
