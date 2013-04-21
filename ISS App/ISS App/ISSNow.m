//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "ISSNow.h"

@implementation ISSNow


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.message  = [json objectForKey:@"message"];
 self.timestamp  = [json objectForKey:@"timestamp"];
 self.iss_position  = [[Iss_positionEntity alloc] initWithJson:[json objectForKey:@"iss_position"]];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.message forKey:@"zx_message"];
[aCoder encodeObject:self.timestamp forKey:@"zx_timestamp"];
[aCoder encodeObject:self.iss_position forKey:@"zx_iss_position"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.message = [aDecoder decodeObjectForKey:@"zx_message"];
 self.timestamp = [aDecoder decodeObjectForKey:@"zx_timestamp"];
 self.iss_position = [aDecoder decodeObjectForKey:@"zx_iss_position"];
 
    }
    return self;
}



@end
