//
//  APIClient.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIClient : AFHTTPSessionManager

typedef void (^APISuccessBlock)(id data);
typedef void (^APIFailureBlock)(NSError *error);

typedef enum {
    RequestMethodGET,
    RequestMethodPOST
} RequestMethod;

@property (strong, nonatomic) NSString *requestPath;
@property (strong, nonatomic) Class modelClass;
@property (copy, nonatomic) APISuccessBlock requestSuccessBlock;
@property (copy, nonatomic) APIFailureBlock requestFailureBlock;
@property (strong, nonatomic) NSMutableDictionary *requestParameters;
@property (assign, nonatomic) RequestMethod requestMethod;

+ (APIClient *)sharedClient;

#pragma mark - Public methods

- (void)startRequestWithPath:(NSString *)path
                  parameters:(NSDictionary *)parameters
                      method:(RequestMethod)method
                  modelClass:(Class)modelClass
                successBlock:(APISuccessBlock)success
                failureBlock:(APIFailureBlock)failure;

- (void)cancelRequests;



@end
