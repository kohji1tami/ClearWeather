//
//  Weather.m
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (Weather*)parseJSON:(NSDictionary*)data
{
    Weather* weather = [[Weather alloc] init];
    weather.temp_max = [self translateDouble:[[[data valueForKey:@"main"] valueForKey:@"temp_max"] doubleValue]];
    weather.temp_min = [self translateDouble:[[[data valueForKey:@"main"] valueForKey:@"temp_min"] doubleValue]];
    weather.name = [data valueForKey:@"name"];
    weather.main = [[data valueForKey:@"weather"][0] valueForKey:@"main"];
    weather.aDescription = [[data valueForKey:@"weather"][0] valueForKey:@"description"];
    // NSLog(@"%@", weatherData);
    return weather;
}

+ (NSString*)translateDouble:(double)doubleValue
{
    return [NSString stringWithFormat:@"%1.0f∘", floor(doubleValue - 273.15)];
}

@end