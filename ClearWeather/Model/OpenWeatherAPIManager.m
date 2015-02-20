//
//  OpenWeatherAPIManager.m
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//


#import "OpenWeatherAPIManager.h"

@interface OpenWeatherAPIManager()

@end

static OpenWeatherAPIManager* _sharedManager = nil;

@implementation OpenWeatherAPIManager

// シングルトン用のクラスメソッド
+ (OpenWeatherAPIManager*)sharedManager
{
    if (!_sharedManager) {
        _sharedManager = [[OpenWeatherAPIManager alloc] init];
    }
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

// 天気予報を取得するメソッド
- (void)getWeatherWith:(WeatherBlock)callback
{
    // APIのベースURL
    NSString* baseURL = @"http://api.openweathermap.org/data/2.5/weather?";
    // パラメータ
    NSDictionary* params = @{
                             @"q": @"Tokyo,jp"
                             };
    // AFNetworkingで通信開始
    [[AFHTTPRequestOperationManager manager] GET:baseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            // Controllerへ通知のためのブロック
            callback([Weather parseJSON:responseObject]);
        }
        NSLog(@"Operation: %@", operation);
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

// 一週間の天気予報を取得するメソッド
- (void)getWeatherOfDailyWith:(ArrayBlock)callback
{
    NSString* baseURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?";
    NSDictionary* params = @{
                             @"q": @"Tokyo",
                             @"mode": @"json",
                             @"units": @"metric",
                             @"cnt": @"7"
                             };
    [[AFHTTPRequestOperationManager manager] GET:baseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback([DailyWeather parseJSON:responseObject]);
        }
        NSLog(@"Operation: %@", operation);
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
