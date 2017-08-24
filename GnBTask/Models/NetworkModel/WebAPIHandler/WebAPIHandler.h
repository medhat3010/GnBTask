//
//  WebAPIHandler.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"


@interface WebAPIHandler : NSObject

+ (void)getProductsWithCount:(NSInteger)count andfrom:(NSInteger) from compleiton:(void (^)(id data))successBlock andfailureBlock:(void (^)(NSError *error))failureBlock;

@end
