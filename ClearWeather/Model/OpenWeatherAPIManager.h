//
//  OpenWeatherAPIManager.h
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Weather.h"
#import "DailyWeather.h"

/****************************************
 
# APIへの接続と、モデルを管理するクラス
 
- このクラスはインスタンスを一つしか作らないシングルトンクラスで実装します。
- 通信処理などはここに集約させる
- Controllerへの通信方法としてKVOやNSNotificationCenterなどがあるが、
  ブロック構文の方が手軽なのでここではブロック構文でcontrollerへ通知します。
 
****************************************/

@interface OpenWeatherAPIManager : NSObject

typedef void (^WeatherBlock)(Weather*);
typedef void (^ArrayBlock)(NSArray*);

+ (OpenWeatherAPIManager*)sharedManager;
- (void)getWeatherWith:(WeatherBlock)callback;
- (void)getWeatherOfDailyWith:(ArrayBlock)callback;

@end
