//
//  Image.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface Image : JSONModel

@property (nonatomic, copy) NSString<Optional> * url;
@property (nonatomic, copy) NSNumber<Optional> * width;
@property (nonatomic, copy) NSNumber<Optional> * height;

@end
