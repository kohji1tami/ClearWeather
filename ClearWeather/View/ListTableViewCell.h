//
//  ListTableViewCell.h
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface ListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView* weatherImage;
@property (nonatomic, strong) UILabel* aDescription;
@property (nonatomic, strong) UILabel* date;
@property (nonatomic, strong) UILabel* temp_max;
@property (nonatomic, strong) UILabel* temp_min;

@end
