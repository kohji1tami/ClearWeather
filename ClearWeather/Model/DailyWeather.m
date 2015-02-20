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

// Jsonをパースするクラスメソッド
+ (NSArray*)parseJSON:(NSDictionary*)data
{
    // lists配列を用の変数
    NSArray* lists = [NSArray arrayWithArray:data[@"list"]];
    // データをまとめたオブジェクトを入れる配列
    NSMutableArray* weatherData = [NSMutableArray array];
    // weatherDataにデータオブジェクトを入れていく
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

// dt はUnix時間なのでこれを変換し、月と日を取り出して返す
+ (NSString*)translateUnixTime:(int)date
{
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitDay
                                                                  fromDate:[NSDate dateWithTimeIntervalSince1970:date]];
    
    return [NSString stringWithFormat:@"%ld/%ld", (long)dateComps.month, (long)dateComps.day];
}

// APIが返してくれる天気はケルビンなので変換して返す
+ (NSString*)translateDouble:(double)doubleValue
{
    return [NSString stringWithFormat:@"%1.0f∘", floor(doubleValue)];
}

@end