//
//  ListTableViewCell.m
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import "ListTableViewCell.h"
#import "Canvas.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _weatherImage = [[UIImageView alloc] init];
        _weatherImage.tintColor = [UIColor whiteColor];
        
        _date = [[UILabel alloc] init];
        _date.textColor = [UIColor whiteColor];
        _date.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25];
        
        _temp_max = [[UILabel alloc] init];
        _temp_max.textColor = [UIColor whiteColor];
        _temp_max.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        _temp_max.textAlignment = NSTextAlignmentRight;
        
        _temp_min = [[UILabel alloc] init];
        _temp_min.textColor = [UIColor whiteColor];
        _temp_min.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        _temp_min.textAlignment = NSTextAlignmentRight;
        
        _aDescription = [[UILabel alloc] init];
        _aDescription.textColor = [UIColor whiteColor];
        _aDescription.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        
        [self.contentView addSubview:_weatherImage];
        [self.contentView addSubview:_date];
        [self.contentView addSubview:_temp_max];
        [self.contentView addSubview:_temp_min];
        [self.contentView addSubview:_aDescription];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize kCellSize = self.frame.size;
    
    _weatherImage.frame = CGRectMake(0, 0, 80, 80);
    _weatherImage.layer.position = CGPointMake(kCellSize.width/2, kCellSize.height/2);
    
    _date.frame = CGRectMake(20, 20, 100, 40);
    
    _temp_max.frame = CGRectMake(kCellSize.width - 120, 20, 100, 40);
    
    _temp_min.frame = CGRectMake(kCellSize.width - 120, 50, 100, 40);
    
    _aDescription.frame = CGRectMake(20, 45, 200, 40);
}

@end
