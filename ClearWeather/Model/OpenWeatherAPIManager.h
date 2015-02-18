//
//  OpenWeatherAPIManager.h
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface OpenWeatherAPIManager : NSObject

typedef void (^WeatherBlock)(Weather*);
typedef void (^ArrayBlock)(NSArray*);

+ (OpenWeatherAPIManager*)sharedManager;
- (void)getWeatherWith:(WeatherBlock)callback;
- (void)getWeatherOfDailyWith:(ArrayBlock)callback;

@end
