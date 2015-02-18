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

- (void)getWeatherWith:(WeatherBlock)callback
{
    NSString* baseURL = @"http://api.openweathermap.org/data/2.5/weather?";
    NSDictionary* params = @{
                             @"q": @"Tokyo,jp"
                             };
    [[AFHTTPRequestOperationManager manager] GET:baseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(callback){
            callback([Weather parseJSON:responseObject]);
        }
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

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
        if(callback){
            callback([DailyWeather parseJSON:responseObject]);
        }
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
