//
//  API.m
//  ISS App
//
//  Created by Daan Lemmen on 20-04-13.
//  Copyright (c) 2013 Daan Lemmen. All rights reserved.
//

#import "API.h"
@interface  API ()
@property (nonatomic, strong) MKNetworkEngine *networkEngine;
@end
@implementation API
- (id)init {
    self = [super init];
    if (self) {
        self.networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"api.open-notify.org"];
    }
    return self;
}
- (void)issLocation:(void (^)(ISSNow *issNow))completionBlock error:(void (^)(NSError *error))errorBlock {
    MKNetworkOperation *operation = [self.networkEngine operationWithPath:@"iss-now" params:[@{} mutableCopy] httpMethod:@"GET" ssl:NO];
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        ISSNow *issNow = [[ISSNow alloc] initWithJson:[completedOperation responseJSON]];
        completionBlock(issNow);
    } onError:^(NSError *error) {
        errorBlock(error);
    }];
    [self.networkEngine enqueueOperation:operation];
}
- (void)issInfo:(void (^)(ISSInfo *issInfo))completionBlock error:(void (^)(NSError *error))errorBlock {
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:@"https://api.wheretheiss.at/v1/satellites/25544" params:[@{} mutableCopy] httpMethod:@"GET"];
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        ISSInfo *issInfo = [[ISSInfo alloc] initWithJson:[completedOperation responseJSON]];
        completionBlock(issInfo);
    } onError:^(NSError *error) {
        errorBlock(error);
    }];
    [self.networkEngine enqueueOperation:operation];
}
@end
