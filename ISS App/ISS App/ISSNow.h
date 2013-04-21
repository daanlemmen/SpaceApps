//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Iss_positionEntity.h"

@interface ISSNow : NSObject<NSCoding>

@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSNumber *timestamp;
@property (nonatomic,strong) Iss_positionEntity *iss_position;
 


-(id)initWithJson:(NSDictionary *)json;

@end
