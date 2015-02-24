//
//  ViewController.m
//  ClearWeather
//
//  Created by Kenichi Saito on 2/15/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

#import "ViewController.h"
#import "OpenWeatherAPIManager.h"
#import "ListTableViewCell.h"
#import "Canvas.h"

@interface ViewController () <UITableViewDataSource>

// UIパーツ用のプロパティ
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* weatherImage;
@property (nonatomic, strong) UILabel*     weatherDescription;
@property (nonatomic, strong) UILabel*     weatherMaxTemp;
@property (nonatomic, strong) UILabel*     weatherMinTemp;
@property (nonatomic, strong) UILabel*     name;

// 一週間の天気の配列を入れるプロパティ
@property (nonatomic, strong) NSArray* weatherData;

@end

@implementation ViewController

// 各UIパーツを配置していく
// Storyboardを使うならここのコードは全て不要になります。
- (void)loadView
{
    [super loadView];
    
    // スクリーンサイズを取得
    CGSize kScreenSize = [UIScreen mainScreen].bounds.size;
    
    self.view.layer.cornerRadius = 10;
    // 背景を変える
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
    
    // 天気を表示するImageViewの設定
    _weatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width/3, kScreenSize.width/3)];
    _weatherImage.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2);
    _weatherImage.tintColor = [UIColor whiteColor];
    
    // 天気の説明をするUILabelの設定
    _weatherDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _weatherDescription.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2 + kScreenSize.width/5);
    _weatherDescription.textAlignment = NSTextAlignmentCenter;
    _weatherDescription.textColor = [UIColor whiteColor];
    _weatherDescription.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    
    // 場所表示をするUILabelの設定
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _name.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2 - kScreenSize.width/5);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor whiteColor];
    _name.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    
    // 最高気温を表示するUILabelの設定
    _weatherMaxTemp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _weatherMaxTemp.layer.position = CGPointMake(kScreenSize.width/4, kScreenSize.width/2);
    _weatherMaxTemp.textAlignment = NSTextAlignmentLeft;
    _weatherMaxTemp.textColor = [UIColor whiteColor];
    _weatherMaxTemp.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    
    // 最低気温を表示するUILabelの設定
    _weatherMinTemp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _weatherMinTemp.layer.position = CGPointMake(3*kScreenSize.width/4, kScreenSize.width/2);
    _weatherMinTemp.textAlignment = NSTextAlignmentRight;
    _weatherMinTemp.textColor = [UIColor whiteColor];
    _weatherMinTemp.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    
    // UITableViewの設定
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenSize.height/2, kScreenSize.width, kScreenSize.height/2)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.rowHeight = 100;
    _tableView.dataSource = self;
    
    // 作成したViewを画面に追加
    [self.view addSubview:_weatherImage];
    [self.view addSubview:_weatherDescription];
    [self.view addSubview:_name];
    [self.view addSubview:_weatherMaxTemp];
    [self.view addSubview:_weatherMinTemp];
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 一週間の天気を取得する
    [[OpenWeatherAPIManager sharedManager] getWeatherOfDailyWith:^(NSArray* response){
        // 取得した天気をプロパティに入れる
        _weatherData = response;
        
        // メインキューでtableViewを更新
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
    
    // 天気を取得してそのまま結果を表示
    [[OpenWeatherAPIManager sharedManager] getWeatherWith:^(Weather* response){
        // Viewに反映
        _weatherImage.image = [[UIImage imageNamed:response.main] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _weatherDescription.text = response.aDescription;
        _name.text = response.name;
        _weatherMaxTemp.text = response.temp_max;
        _weatherMinTemp.text = response.temp_min;
        
        // アニメーションをしない場合は不要
        [self animationWithDelay:0.6 andView:_weatherImage];
        [self animationWithDelay:0.2 andView:_weatherDescription];
        [self animationWithDelay:0.4 andView:_name];
        [self animationWithDelay:0.3 andView:_weatherMaxTemp];
        [self animationWithDelay:0.1 andView:_weatherMinTemp];
    }];
}

#pragma mark - UItableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weatherData.count;
}

// このメソッドないでCellを更新するのではなく、別のメソッドで更新する
- (ListTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell* cell;
    cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [self updateCell:cell forIndexPath:indexPath];
    return cell;
}

// Cell更新用のメソッド
- (void)updateCell:(ListTableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    DailyWeather* dailyWeather = _weatherData[indexPath.row];
    cell.date.text = dailyWeather.dt;
    cell.weatherImage.image = [[UIImage imageNamed:dailyWeather.main] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.aDescription.text = dailyWeather.aDescription;
    cell.temp_max.text = dailyWeather.temp_max;
    cell.temp_min.text = dailyWeather.temp_min;
}

// アニメーションをしない場合は不要
- (void)animationWithDelay:(NSTimeInterval)delay andView:(UIView*)view
{
    CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.duration = 0.5;
    animationView.delay    = delay;
    animationView.type     = CSAnimationTypeFadeIn;
    
    [self.view addSubview:animationView];
    [animationView addSubview:view];
    
    [animationView startCanvasAnimation];
}

@end
