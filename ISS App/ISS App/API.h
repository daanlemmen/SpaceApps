//
//  API.h
//  ISS App
//
//  Created by Daan Lemmen on 20-04-13.
//  Copyright (c) 2013 Daan Lemmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISSNow.h"
#import "ISSInfo.h"
#import "MKNetworkKit.h"
@interface API : NSObject
- (void)issLocation:(void (^)(ISSNow *issNow))completionBlock error:(void (^)(NSError *error))errorBlock;
- (void)issInfo:(void (^)(ISSInfo *issInfo))completionBlock error:(void (^)(NSError *error))errorBlock;
@end
