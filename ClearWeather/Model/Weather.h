//
//  Weather.h
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSString* aDescription;
@property (nonatomic, strong) NSString* temp_min; // must minus 273.15
@property (nonatomic, strong) NSString* temp_max;
@property (nonatomic, strong) NSString* main;
@property (nonatomic, strong) NSString* name;

+ (Weather*)parseJSON:(NSDictionary*)data;

@end
