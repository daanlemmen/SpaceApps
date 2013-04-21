//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface ISSInfo : NSObject<NSCoding>

@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSNumber *footprint;
@property (nonatomic,strong) NSNumber *velocity;
@property (nonatomic,strong) NSNumber *timestamp;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;
@property (nonatomic,strong) NSString *units;
@property (nonatomic,strong) NSNumber *solar_lat;
@property (nonatomic,strong) NSString *visibility;
@property (nonatomic,strong) NSNumber *daynum;
@property (nonatomic,strong) NSNumber *solar_lon;
@property (nonatomic,strong) NSNumber *altitude;
@property (nonatomic,strong) NSString *name;
 


-(id)initWithJson:(NSDictionary *)json;

@end
