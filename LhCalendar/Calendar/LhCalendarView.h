//
//  LhCalendarView.h
//  LhCalendar
//
//  Created by 刘慧 on 2018/1/31.
//  Copyright © 2018年 刘慧. All rights reserved.
//

/*  日 一 二 三 四 五 六 下面以“星期”表示  */

#import <UIKit/UIKit.h>

/**
 点击日期的协议
 */
@protocol LhCalendarViewDelegate <NSObject>

- (void)calendarView:(NSIndexPath *)indexPath dateString:(NSString *)dateString;

@end

@interface LhCalendarView : UIView

@property (nonatomic, strong) NSString *startDay;  //开始的时间
@property (nonatomic, strong) NSString *endDay;    //结束的时间
@property (nonatomic, weak) id<LhCalendarViewDelegate> calendarDelegate;

- (instancetype)initWithFrame:(CGRect)frame startDay:(NSString *)startDay endDay:(NSString *)endDay;


/**
<<<<<<< HEAD
 月
=======
 月  暂不可打点设置修改
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
 */
@property (nonatomic, strong) UIColor *currentMonthTitleColor;      //当前月份的字体颜色  默认：红色
@property (nonatomic, strong) UIColor *normalMonthTitleColor;       //非当前月份的字体颜色  默认：黑色

/**
<<<<<<< HEAD
 天
=======
 天  暂不可打点设置修改 
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
 */
@property (nonatomic, strong) UIColor *currentDayBackgroundColor;   //当前日期的背景颜色  默认：红色
@property (nonatomic, strong) UIColor *currentDayTitleColor;        //当前日期的字体颜色  默认：白色
@property (nonatomic, strong) UIColor *selectedDayBackgroundColor;  //被选中的某天背景颜色  默认：黑色
@property (nonatomic, strong) UIColor *selectedDayTitleColor;       //被选中的某天字体颜色  默认：白色
@property (nonatomic, strong) UIColor *normalDayTitleColor;         //正常日期的字体颜色  默认：黑色
@property (nonatomic, strong) UIColor *weekdayTitleColor;           //周末日期的字体颜色  默认：红色


/**
<<<<<<< HEAD
 星期
=======
 星期  可打点设置修改
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
 */
@property (nonatomic, assign) BOOL hiddenWeekLine;   //是否影藏星期底线 YES影藏 NO不影藏 默认：YES
@property (nonatomic, strong) UIColor *weekBackgroundColor; //星期的背景颜色 默认：白色
@property (nonatomic, strong) UIColor *weekTitleColor;      //星期字体颜色 默认：黑色
@property (nonatomic, strong) UIColor *weekLineColor;       //星期底线颜色 默认：灰色
@property (nonatomic, strong) UIColor *weekendTitleColor;   //周末字体颜色 默认：灰色

@property (nonatomic, strong) UIFont *weekTitleFont;      //星期的字体大小 默认：12   日~六统一字体大小，暂不分开
@property (nonatomic, assign) CGFloat weekLineHeight;     //星期底线的高度 默认：0.7


@end



/**
 日期的model
 */
@interface LhCalendarModel : NSObject

@property (nonatomic, assign) NSInteger year;         //年
@property (nonatomic, assign) NSInteger month;        //月
@property (nonatomic, copy) NSString *day;            //日
@property (nonatomic, assign) NSInteger weekday;      //星期
@property (nonatomic, assign) BOOL isToday;           //是否是今天
@property (nonatomic, assign) BOOL isSelected;        //是否是被选择日期
@property (nonatomic, assign) BOOL isExpiredDate;     //是否是过期日期（startDay以前的时间）
@property (nonatomic, assign) BOOL isFutureDate;      //是否是未来日期（超出endDay的时间）

@end
