//
//  APIClient.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+ (APIClient *)sharedClient {
    static APIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] initWithBaseURL:nil sessionConfiguration:nil];
    });
    return sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(nullable NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    
    if(self) {
        [self setupRequestSerializer];
        [self setupResponseSerializer];
    }
    
    return self;
}

- (void)setupRequestSerializer
{
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.requestSerializer.timeoutInterval = 20.0f;
}

- (void)setupResponseSerializer
{
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"application/json",@"text/html",@"application/rss+xml", @"text/plain", nil];
}

- (void)startRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters method:(RequestMethod)method modelClass:(Class)modelClass successBlock:(APISuccessBlock)successBlock failureBlock:(APIFailureBlock)failureBlock
{
    [self setRequestPath:path
              parameters:parameters
                  method:method
              modelClass:modelClass
            successBlock:successBlock
            failureBlock:failureBlock];
    
    NSString *newPath = self.requestPath;
    
    if(method == RequestMethodGET)
    {
        [self GET:newPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
        }];
    }
    
    else if (method == RequestMethodPOST)
    {
        [self POST:newPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
        }];
    }
}

- (void)setRequestPath:(NSString *)path parameters:(NSDictionary *)parameters method:(RequestMethod)method modelClass:(Class)modelClass successBlock:(APISuccessBlock)successBlock failureBlock:(APIFailureBlock)failureBlock
{
    self.requestPath = path;
    self.requestParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    self.requestMethod = method;
    self.modelClass = modelClass;
    self.requestSuccessBlock = successBlock;
    self.requestFailureBlock = failureBlock;
}

- (void)cancelRequests
{
    for(NSURLSessionTask *task in self.tasks) {
        [task cancel];
    }
}

@end
