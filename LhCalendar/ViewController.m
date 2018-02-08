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
    
    
    
    
    //增加一些常用的东西 可多种方式实现
    NSDateComponents *components = [self differDaysBetweenDate:@"2018-01-08" endDateStr:@"2018-07-22"];
    NSLog(@"相差%zd天",components.day);
    
    NSLog(@"距离高考还有%ld天",[self getDifferenceByDate:@"2018-07-22"]);
    
    [self differDayDate];
    
    NSLog(@"100天后的日期为：%@",[self afterDayWithDate:100]);
}


/**
 LhCalendarView日期类里的协议回调方法

 @param indexPath 选中日期UICollectionView的indexPath
 @param dateString 选中日期的字符串
 */
- (void)calendarView:(NSIndexPath *)indexPath dateString:(NSString *)dateString{
    NSLog(@"click=%@",dateString);
}




- (NSString *)afterDayWithDate:(NSInteger)day{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval2 = nowDate.timeIntervalSince1970;
    NSTimeInterval newTime = day*24*3600 + timeInterval2;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:newTime];
    NSString *newStr = [dateFormatter stringFromDate:newDate];
    return newStr;
}

- (void)differDayDate{
    //现在的时间
    NSDate * nowDate = [NSDate date];
    //要转换的字符串
    NSString * dateString = @"2018-04-30";
    //字符串转NSDate格式的方法
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate * valueDate = [dateFormatter dateFromString:dateString];
    //计算两个中间差值(秒)
    NSTimeInterval time = [nowDate timeIntervalSinceDate:valueDate];
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    NSString * dateValue = [NSString stringWithFormat:@"%i",days];
    
    NSLog(@"打印出时间的差值--->>%@",dateValue);
}

- (NSInteger)getDifferenceByDate:(NSString *)date {
    //获得当前时间
    NSDate *now = [NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:now toDate:oldDate options:0];
    return [comps day];
}

#pragma mark -- 计算两个日期之间相差天数
- (NSDateComponents *)differDaysBetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate          *startDate     = [dateFormatter dateFromString:startDateStr];
    NSDate          *endDate       = [dateFormatter dateFromString:endDateStr];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
//    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth;
    NSCalendarUnit unit = NSCalendarUnitDay;
    
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    return delta;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
