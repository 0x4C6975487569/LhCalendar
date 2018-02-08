//
//  ViewController.m
//  LhCalendar
//
//  Created by 刘慧 on 2018/1/31.
//  Copyright © 2018年 刘慧. All rights reserved.
//

#import "ViewController.h"
#import "LhCalendarView.h"

@interface ViewController ()<LhCalendarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LhCalendarView *calendarView = [[LhCalendarView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-78) startDay:@"2018-01-08" endDay:@"2018-07-22"];
//    LhCalendarView *calendarView = [[LhCalendarView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-78) startDay:@"2018-01-08" endDay:@"2018-07-22"];
//    calendarView.weekBackgroundColor = [UIColor cyanColor];
//    calendarView.weekTitleColor = [UIColor blueColor];
//    calendarView.weekendTitleColor = [UIColor yellowColor];
//    calendarView.weekLineHeight = 2;
//    calendarView.weekTitleFont = [UIFont systemFontOfSize:15];
//    calendarView.weekLineColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    calendarView.hiddenWeekLine = NO;
    calendarView.calendarDelegate = self;
    [self.view addSubview:calendarView];
    
}


/**
 LhCalendarView日期类里的协议回调方法

 @param indexPath 选中日期UICollectionView的indexPath
 @param dateString 选中日期的字符串
 */
- (void)calendarView:(NSIndexPath *)indexPath dateString:(NSString *)dateString{
    NSLog(@"click=%@",dateString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
