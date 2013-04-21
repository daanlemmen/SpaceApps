//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "ISSInfo.h"

@implementation ISSInfo


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.id  = [json objectForKey:@"id"];
 self.footprint  = [json objectForKey:@"footprint"];
 self.velocity  = [json objectForKey:@"velocity"];
 self.timestamp  = [json objectForKey:@"timestamp"];
 self.longitude  = [json objectForKey:@"longitude"];
 self.latitude  = [json objectForKey:@"latitude"];
 self.units  = [json objectForKey:@"units"];
 self.solar_lat  = [json objectForKey:@"solar_lat"];
 self.visibility  = [json objectForKey:@"visibility"];
 self.daynum  = [json objectForKey:@"daynum"];
 self.solar_lon  = [json objectForKey:@"solar_lon"];
 self.altitude  = [json objectForKey:@"altitude"];
 self.name  = [json objectForKey:@"name"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"zx_id"];
[aCoder encodeObject:self.footprint forKey:@"zx_footprint"];
[aCoder encodeObject:self.velocity forKey:@"zx_velocity"];
[aCoder encodeObject:self.timestamp forKey:@"zx_timestamp"];
[aCoder encodeObject:self.longitude forKey:@"zx_longitude"];
[aCoder encodeObject:self.latitude forKey:@"zx_latitude"];
[aCoder encodeObject:self.units forKey:@"zx_units"];
[aCoder encodeObject:self.solar_lat forKey:@"zx_solar_lat"];
[aCoder encodeObject:self.visibility forKey:@"zx_visibility"];
[aCoder encodeObject:self.daynum forKey:@"zx_daynum"];
[aCoder encodeObject:self.solar_lon forKey:@"zx_solar_lon"];
[aCoder encodeObject:self.altitude forKey:@"zx_altitude"];
[aCoder encodeObject:self.name forKey:@"zx_name"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.id = [aDecoder decodeObjectForKey:@"zx_id"];
 self.footprint = [aDecoder decodeObjectForKey:@"zx_footprint"];
 self.velocity = [aDecoder decodeObjectForKey:@"zx_velocity"];
 self.timestamp = [aDecoder decodeObjectForKey:@"zx_timestamp"];
 self.longitude = [aDecoder decodeObjectForKey:@"zx_longitude"];
 self.latitude = [aDecoder decodeObjectForKey:@"zx_latitude"];
 self.units = [aDecoder decodeObjectForKey:@"zx_units"];
 self.solar_lat = [aDecoder decodeObjectForKey:@"zx_solar_lat"];
 self.visibility = [aDecoder decodeObjectForKey:@"zx_visibility"];
 self.daynum = [aDecoder decodeObjectForKey:@"zx_daynum"];
 self.solar_lon = [aDecoder decodeObjectForKey:@"zx_solar_lon"];
 self.altitude = [aDecoder decodeObjectForKey:@"zx_altitude"];
 self.name = [aDecoder decodeObjectForKey:@"zx_name"];
 
    }
    return self;
}



@end
