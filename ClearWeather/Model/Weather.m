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

// Jsonをパースするクラスメソッド
+ (Weather*)parseJSON:(NSDictionary*)data
{
    // Weatherのインスタンスを作成
    Weather* weather = [[Weather alloc] init];
    // 与えられたデータをパースしてプロパティに入れる
    weather.temp_max = [self translateDouble:[[[data valueForKey:@"main"] valueForKey:@"temp_max"] doubleValue]];
    weather.temp_min = [self translateDouble:[[[data valueForKey:@"main"] valueForKey:@"temp_min"] doubleValue]];
    weather.name = [data valueForKey:@"name"];
    weather.main = [[data valueForKey:@"weather"][0] valueForKey:@"main"];
    weather.aDescription = [[data valueForKey:@"weather"][0] valueForKey:@"description"];
    return weather;
}

// APIが返してくれる天気はケルビンなので変換して返す
+ (NSString*)translateDouble:(double)doubleValue
{
    return [NSString stringWithFormat:@"%1.0f∘", floor(doubleValue - 273.15)];
}

@end