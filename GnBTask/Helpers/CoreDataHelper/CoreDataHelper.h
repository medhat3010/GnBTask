//
//  CoreDataHelper.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/22/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "CDProduct+CoreDataClass.h"


@interface CoreDataHelper : NSObject

+(BOOL) isInCart:(NSNumber *) productId;
+(void) addToProduct:(NSNumber *) productId;
+(void)deleteProduct:(NSNumber *) productId;

@end
