//
//  DailyWeather.m
//  ClearWeather
//
//  Created by Kenichi Saito on 2/18/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import "DailyWeather.h"

@interface DailyWeather()

@end

@implementation DailyWeather

- (instancetype)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}

+ (NSArray*)parseJSON:(NSDictionary*)data
{
    NSArray* lists = [NSArray arrayWithArray:data[@"list"]];
    NSMutableArray* weatherData = [NSMutableArray array];
    for (id list in lists) {
        DailyWeather* weather = [[DailyWeather alloc] init];
        weather.dt = [self translateUnixTime:[[list valueForKey:@"dt"] intValue]];
        weather.temp_max = [self translateDouble:[[[list valueForKey:@"temp"] valueForKey:@"max"] doubleValue]];
        weather.temp_min = [self translateDouble:[[[list valueForKey:@"temp"] valueForKey:@"min"] doubleValue]];
        weather.main = [[list valueForKey:@"weather"][0] valueForKey:@"main"];
        weather.aDescription = [[list valueForKey:@"weather"][0] valueForKey:@"description"];
        [weatherData addObject:weather];
    }
    return weatherData;
}

+ (NSString*)translateUnixTime:(int)date
{
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitDay
                                                                  fromDate:[NSDate dateWithTimeIntervalSince1970:date]];
    
    return [NSString stringWithFormat:@"%ld/%ld", (long)dateComps.month, (long)dateComps.day];
}

+ (NSString*)translateDouble:(double)doubleValue
{
    return [NSString stringWithFormat:@"%1.0f∘", floor(doubleValue)];
}

@end