//
//  WebAPIHandler.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "WebAPIHandler.h"

static NSString * const GlobalUrl = @"http://grapesnberries.getsandbox.com/";
static NSString * const Products = @"products";


@implementation WebAPIHandler


+(void)getProductsWithCount:(NSInteger)count andfrom:(NSInteger)from compleiton:(void (^)(id))successBlock andfailureBlock:(void (^)(NSError *))failureBlock
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
        NSString * getProductUrl = [NSString stringWithFormat:@"%@%@?count=%li&from=%li",GlobalUrl,Products,(long)count,(long)from];
    NSLog(@"URL : %@",getProductUrl);
        [[APIClient sharedClient] startRequestWithPath:getProductUrl parameters:nil method:RequestMethodGET modelClass:nil successBlock:^(id data) {
            successBlock(data);
        } failureBlock:^(NSError *error) {
            failureBlock(error);
        }];
}

@end
