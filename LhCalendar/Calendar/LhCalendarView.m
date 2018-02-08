//
//  LhCalendarView.m
//  LhCalendar
//
//  Created by 刘慧 on 2018/1/31.
//  Copyright © 2018年 刘慧. All rights reserved.
//

#define WeekHeight_lh 32.0  //星期的高度 （日 一 二 三 四 五 六）
#define CollectionHeadHeight 44.0  //collection头的高度 可设为self.frame.size.width/7

#import "LhCalendarView.h"

@interface LhCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *weekArray;   //星期的数组 日~六
@property (nonatomic, strong) UIView *weekView;     //星期的View 日~六
@property (nonatomic, strong) UIView *weekLineView; //星期底线的View
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dateDataArray;  //startDay~endDay的月份数据
@property (nonatomic, strong) NSIndexPath *lastIndexPath;  //记录最后一次点击的IndexPath

@end

@implementation LhCalendarView

- (instancetype)initWithFrame:(CGRect)frame startDay:(NSString *)startDay endDay:(NSString *)endDay{
    self = [super initWithFrame:frame];
    if (self) {
        _startDay = startDay.length ? startDay : [self dateWithTimeInterval:[NSDate date].timeIntervalSince1970];
        _endDay = endDay.length ? endDay : [self dateWithTimeInterval:[NSDate date].timeIntervalSince1970];
        
        //各属性默认值设置
        _currentMonthTitleColor = [UIColor redColor];       //当前月份的字体颜色  默认：红色
        _normalMonthTitleColor = [UIColor blackColor];      //非当前月份的字体颜色  默认：黑色
        _currentDayBackgroundColor = [UIColor redColor];    //当前日期的背景颜色  默认：红色
        _currentDayTitleColor = [UIColor whiteColor];       //当前日期的字体颜色  默认：白色
        _selectedDayBackgroundColor = [UIColor blackColor]; //被选中的某天背景颜色  默认：黑色
        _selectedDayTitleColor = [UIColor whiteColor];      //被选中的某天字体颜色  默认：白色
        _normalDayTitleColor = [UIColor blackColor];        //正常日期的字体颜色  默认：黑色
        _weekdayTitleColor = [UIColor redColor];            //周末日期的字体颜色  默认：红色
        
        _weekBackgroundColor = [UIColor whiteColor];        //星期的背景颜色 默认：白色
        _weekTitleColor = [UIColor blackColor];             //星期字体颜色 默认：黑色
        _weekLineColor = [UIColor lightGrayColor];          //星期底线颜色 默认：灰色
        _weekendTitleColor = [UIColor lightGrayColor];      //周末字体颜色 默认：灰色
        
        _weekTitleFont = [UIFont systemFontOfSize:12];      //星期的字体大小 默认：12   日~六统一字体大小，暂不分开
        _weekLineHeight = 0.7f;                             //星期底线的高度 默认：0.7
        
        _hiddenWeekLine = YES;                              //是否影藏星期底线 YES影藏 NO不影藏 默认：YES
        
        [self loadingData];
        [self addSubview:self.weekView];
        [self addSubview:self.weekLineView];
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - loadingData 加载所需日期

- (void)loadingData{
    NSArray *startArray = [self.startDay componentsSeparatedByString:@"-"];
    NSArray *endArray = [self.endDay componentsSeparatedByString:@"-"];
    NSInteger monthNum = ([endArray[0] integerValue]-[startArray[0] integerValue])*12+[endArray[1] integerValue]-[startArray[1] integerValue]+1;
    
    for (int i=0; i<monthNum; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [self.dateDataArray addObject:array];
    }
    
    NSDateFormatter *dateFormatter = [self setupDateFormatter];
    NSDate *startDate = [dateFormatter dateFromString:self.startDay];
    NSDate *endDate = [dateFormatter dateFromString:self.endDay];
<<<<<<< HEAD
    NSLog(@"startDate==%@  endDate==%@",startDate,endDate);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:startDate];
    NSLog(@"%ld,%ld,%ld,%ld",components.year,components.month,components.day,components.weekday);
=======
//    NSLog(@"startDate==%@  endDate==%@",startDate,endDate);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:startDate];
//    NSLog(@"%ld,%ld,%ld,%ld",components.year,components.month,components.day,components.weekday);
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
    
    for (int i=0; i<monthNum; i++) {
        NSInteger month = (components.month+i)%12; //获取开始的月份
        NSDateComponents *nextComponents = [[NSDateComponents alloc]init];
        nextComponents.year = components.year + (components.month+i)/13;
        nextComponents.month = month==0 ? 12:month;
        nextComponents.day = 1; //需要判断当前月份有多少天 后面可以设置
<<<<<<< HEAD
//        NSLog(@"===%ld,%ld,%ld",nextComponents.year,nextComponents.month,nextComponents.day);
=======
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
        NSDate *nextDate = [[NSCalendar currentCalendar] dateFromComponents:nextComponents];
        //该月第一天星期几
        NSInteger weekdayOfTheFirstDay = [self weekdayInFirstDayOfTheMonth:nextDate];
        //该月有多少天
        NSInteger daysInThisMonth = [self daysInThisMonth:nextDate];
<<<<<<< HEAD
//        NSLog(@"%ld--%ld",weekdayOfTheFirstDay,daysInThisMonth);
=======
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
        
        NSInteger dayNum = 0;
        if (daysInThisMonth==28 && weekdayOfTheFirstDay==0) {
            dayNum = 28;
        }else if (daysInThisMonth==29){
            dayNum = 35;
        }else if (daysInThisMonth<=30 && weekdayOfTheFirstDay<=5){
            dayNum = 35;
        }else if (daysInThisMonth==31 && weekdayOfTheFirstDay<=4){
            dayNum = 35;
        }else{
            dayNum = 42;
        }
        NSString *dayStr = [[NSString alloc]init];
        for (int j=0; j<dayNum; j++) {
            LhCalendarModel *calendarModel = [[LhCalendarModel alloc]init];
            calendarModel.year = nextComponents.year;
            calendarModel.month = nextComponents.month;
            if (j<weekdayOfTheFirstDay || j>(daysInThisMonth+weekdayOfTheFirstDay-1)) {
                dayStr = @"";
                calendarModel.day = dayStr;
            }else{
                dayStr = [NSString stringWithFormat:@"%02zd",j-weekdayOfTheFirstDay+1];//单位数是前带0 例如：06
                calendarModel.day = [NSString stringWithFormat:@"%zd",j-weekdayOfTheFirstDay+1];//单位数是前不带0 例如：6
                NSString *dateStr = [NSString stringWithFormat:@"%zd-%02zd-%@",calendarModel.year,calendarModel.month,dayStr];//直接赋带0的前去判断
                //是否是今天
                calendarModel.isToday = [self isToday:dateStr];
                //今天星期几
                calendarModel.weekday = [self weekOfTheToday:[NSString stringWithFormat:@"%zd-%zd-%@",calendarModel.year,calendarModel.month,calendarModel.day]];
                //日期是否过期(startDay开始，也可今天[NSDate date])
                int isExpiredDate = [self compareFirstDate:startDate withSecondDate:[[self setupDateFormatter] dateFromString:[NSString stringWithFormat:@"%zd-%zd-%@",calendarModel.year,calendarModel.month,calendarModel.day]]];
<<<<<<< HEAD
//                NSLog(@"%@ %d %@",[NSDate date],isExpiredDate,[[self setupDateFormatter] dateFromString:[NSString stringWithFormat:@"%zd-%zd-%@",calendarModel.year,calendarModel.month,calendarModel.day]]);
=======
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
                calendarModel.isExpiredDate = isExpiredDate == 1 ? YES : NO;
                //日期是否超出(endDay开始)
                int isFutureDate = [self compareFirstDate:endDate withSecondDate:[[self setupDateFormatter] dateFromString:[NSString stringWithFormat:@"%zd-%zd-%@",calendarModel.year,calendarModel.month,calendarModel.day]]];
                calendarModel.isFutureDate = isFutureDate == -1 ? YES : NO;
            }
            
            [[self.dateDataArray objectAtIndex:i] addObject:calendarModel];
        }
    }
}

//日期数组
- (NSMutableArray *)dateDataArray{
    if (!_dateDataArray) {
        _dateDataArray = [NSMutableArray array];
    }
    return _dateDataArray;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource 协议方法（UICollectionView）

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dateDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dateDataArray[section] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionITEM_lh" forIndexPath:indexPath];
    if (cell != nil) {
        while (cell.contentView.subviews.lastObject != nil) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    LhCalendarModel *model = self.dateDataArray[indexPath.section][indexPath.item];
    
    UILabel *cellLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    
    if (model.isToday) {
        //今天的日期设置
        cellLab.backgroundColor = _currentDayBackgroundColor;
        cellLab.textColor = _currentDayTitleColor;
    }else if (model.weekday == 0 || model.weekday == 6) {
        //周六周日设置
        cellLab.textColor = _weekdayTitleColor;
    }else{
        //其他设置
        cellLab.backgroundColor = [UIColor clearColor];
        cellLab.textColor = _normalDayTitleColor;
    }
    
    //过期的日期、超出的日期 透明度降低设置
    if (model.isExpiredDate || model.isFutureDate) {
        cellLab.alpha = 0.3;
    }
    
    //被选择的日期设置
    if (model.isSelected) {
        cellLab.backgroundColor = _selectedDayBackgroundColor;
        cellLab.textColor = _selectedDayTitleColor;
    }
    
    cellLab.textAlignment = NSTextAlignmentCenter;
    cellLab.text = [NSString stringWithFormat:@"%@",model.day];
    cellLab.font = [UIFont systemFontOfSize:14];
    cellLab.layer.cornerRadius = cellLab.bounds.size.width/2;
    cellLab.layer.masksToBounds = YES;
    [cell.contentView addSubview:cellLab];
    
    //被选择的日期动画效果
    if (model.isSelected) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.duration = 0.25;
        animation.keyPath = @"transform.scale";
        animation.values = @[@0.6,@1.2,@1.0];
        animation.calculationMode = kCAAnimationPaced;
        [cellLab.layer addAnimation:animation forKey:nil];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHead_lh" forIndexPath:indexPath];
        if (headView != nil) {
            while (headView.subviews.lastObject != nil) {
                [headView.subviews.lastObject removeFromSuperview];
            }
        }
        LhCalendarModel *model = self.dateDataArray[indexPath.section][indexPath.item];
        BOOL isCurrentMonth = [self isCurrentMonth:[NSString stringWithFormat:@"%zd-%02zd",model.year,model.month]];
        UILabel *yearAndMonthLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, headView.bounds.size.width-40, headView.bounds.size.height-10)];
        yearAndMonthLab.text = [NSString stringWithFormat:@"%zd年%02zd月",model.year,model.month];
        yearAndMonthLab.textAlignment = NSTextAlignmentCenter;
        yearAndMonthLab.textColor = isCurrentMonth ? _currentMonthTitleColor : _normalMonthTitleColor;
        yearAndMonthLab.font = [UIFont systemFontOfSize:14];
        [headView addSubview:yearAndMonthLab];
        
        return headView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LhCalendarModel *model = self.dateDataArray[indexPath.section][indexPath.item];
    //点击任何日期都可（根据需求可以在展示效果里面判断分开进行先后顺序进行排除：例如，自己弄吧）
    //例如:过期日期、超出日期 不可点击
    if (model.isExpiredDate || model.isFutureDate) {
        return;
    }
    if ([self.calendarDelegate respondsToSelector:@selector(calendarView:dateString:)]) {
        //暂传数据 例如: 2018-9-3 如需传2018-09-03 可设置前带0
        [self.calendarDelegate calendarView:indexPath dateString:[NSString stringWithFormat:@"%zd-%zd-%@",model.year,model.month,model.day]];
    }
    
    if (model.isToday || model.isSelected || !model.day.length || model.isExpiredDate) {//点击此未有其他展示效果
        return;
    }
    if (_lastIndexPath) {
        LhCalendarModel *lastModel = self.dateDataArray[_lastIndexPath.section][_lastIndexPath.item];
        lastModel.isSelected = NO;
        self.dateDataArray[_lastIndexPath.section][_lastIndexPath.item] = lastModel;
    }
    model.isSelected = YES;
    self.dateDataArray[indexPath.section][indexPath.item] = model;
    _lastIndexPath = indexPath;
    [self.collectionView reloadData];
}

#pragma mark - collectionView 创建

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = 0;
        flowlayout.itemSize = CGSizeMake(self.frame.size.width/7, self.frame.size.width/7);
        flowlayout.headerReferenceSize = CGSizeMake(self.frame.size.width, CollectionHeadHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekLineView.frame), self.frame.size.width, self.frame.size.height-CGRectGetMaxY(self.weekLineView.frame)) collectionViewLayout:flowlayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
<<<<<<< HEAD
=======
        //CELL 与 Header 可替换
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionITEM_lh"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHead_lh"];
    }
    return _collectionView;
}

#pragma mark - week 星期

//星期数组
- (NSArray *)weekArray{
    if (_weekArray==nil) {
        _weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weekArray;
}

//星期
- (UIView *)weekView{
    if (!_weekView) {
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, WeekHeight_lh)];
        _weekView.backgroundColor = _weekBackgroundColor;
        
        for (int i=0; i<self.weekArray.count; i++) {
            UILabel *weekLab = [[UILabel alloc]initWithFrame:CGRectMake(i*(self.frame.size.width/_weekArray.count), 0, CGRectGetWidth(self.weekView.frame)/_weekArray.count, CGRectGetHeight(_weekView.frame))];
            weekLab.textAlignment = NSTextAlignmentCenter;
            weekLab.textColor = _weekTitleColor;
            weekLab.text = _weekArray[i];
            weekLab.font = _weekTitleFont;
            weekLab.tag = 65;
            [_weekView addSubview:weekLab];
            
            if (i==0 || i==_weekArray.count-1) {
                weekLab.tag = 66;
                weekLab.textColor = _weekendTitleColor;
            }
        }
    }
    return _weekView;
}

//星期底线
- (UIView *)weekLineView{
    if (!_weekLineView) {
        _weekLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekView.frame), self.frame.size.width, _weekLineHeight)];
        _weekLineView.backgroundColor = _weekLineColor;
        _weekLineView.hidden = _hiddenWeekLine;
    }
    return _weekLineView;
}

#pragma mark - property 属性

//星期的背景颜色
- (void)setWeekBackgroundColor:(UIColor *)weekBackgroundColor{
    _weekBackgroundColor = weekBackgroundColor;
    _weekView.backgroundColor = _weekBackgroundColor;
}

//星期的字体颜色
- (void)setWeekTitleColor:(UIColor *)weekTitleColor{
    _weekTitleColor = weekTitleColor;
    for (UIView *labView in _weekView.subviews) {
        if ([labView isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)labView;
            if (lab.tag == 65) {
                lab.textColor = _weekTitleColor;
            }
        }
    }
}

//星期周末的字体颜色
- (void)setWeekendTitleColor:(UIColor *)weekendTitleColor{
    _weekendTitleColor = weekendTitleColor;
    for (UIView *labView in _weekView.subviews) {
        if ([labView isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)labView;
            if (lab.tag == 66) {
                lab.textColor = _weekendTitleColor;
            }
        }
    }
}

//星期底线的颜色
- (void)setWeekLineColor:(UIColor *)weekLineColor{
    _weekLineColor = weekLineColor;
    _weekLineView.backgroundColor = _weekLineColor;
}

//星期字体的大小
- (void)setWeekTitleFont:(UIFont *)weekTitleFont{
    _weekTitleFont = weekTitleFont;
    for (UIView *labView in _weekView.subviews) {
        if ([labView isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)labView;
            lab.font = _weekTitleFont;
        }
    }
}

//隐藏星期底线
- (void)setHiddenWeekLine:(BOOL)hiddenWeekLine{
    _hiddenWeekLine = hiddenWeekLine;
    _weekLineView.hidden = _hiddenWeekLine;
}

//星期底线的高度
- (void)setWeekLineHeight:(CGFloat)weekLineHeight{
    _weekLineHeight = weekLineHeight;
    _weekLineView.frame = CGRectMake(0, CGRectGetMaxY(self.weekView.frame), self.frame.size.width, _weekLineHeight);
}

#pragma mark - NSDate 日期

//日期的格式
- (NSDateFormatter *)setupDateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}

//获取该月第一天星期几
- (NSInteger)weekdayInFirstDayOfTheMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1]; //设置每月的第一天从周几开始 默认为1 从周日开始
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    [components setDay:1];
    NSDate *firstWeekdayDate = [calendar dateFromComponents:components];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstWeekdayDate];
    return firstWeekday-1; //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
}

//获取当前月有多少天
- (NSInteger)daysInThisMonth:(NSDate *)date{
    NSRange daysRangeOfTheMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysRangeOfTheMonth.length;
}

//判断是否是今天
- (BOOL)isToday:(NSString *)date{
    BOOL isToday = NO;
    NSString *todayStr = [self dateWithTimeInterval:[NSDate date].timeIntervalSince1970];
<<<<<<< HEAD
//    NSLog(@"%@=%@",date,todayStr);
=======
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
    if ([date isEqualToString:todayStr]) {
        isToday = YES;
    }
    return isToday;
}

//判断是否是当前月份
- (BOOL)isCurrentMonth:(NSString *)date{
    BOOL currentMonth = NO;
    NSString *monthStr = [[self dateWithTimeInterval:[NSDate date].timeIntervalSince1970] substringWithRange:NSMakeRange(0, 7)];
    if ([monthStr isEqualToString:date]) {
        currentMonth = YES;
    }
    return currentMonth;
}

//获取当天为星期几
- (NSInteger)weekOfTheToday:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [self setupDateFormatter];
    NSDate *date = [dateFormatter dateFromString:dateStr];
<<<<<<< HEAD
//    NSLog(@"date====%@",date);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
//    NSLog(@"%ld,%ld,%ld,%ld",components.year,components.month,components.day,components.weekday);
=======
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
>>>>>>> 9a1891a0d6daad356fb874d14cc5a5fc3ea5ecdb
    return components.weekday-1;
}

//根据时间戳转换为日期字符串
- (NSString *)dateWithTimeInterval:(NSTimeInterval)timeInterval{
    NSDateFormatter *dateFormatter = [self setupDateFormatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

//比较两日期的大小
- (int)compareFirstDate:(NSDate *)firstDate withSecondDate:(NSDate *)secondDate{
    NSDateFormatter *dateFormatter = [self setupDateFormatter];
    NSString *oneDateStr = [dateFormatter stringFromDate:firstDate];
    NSString *twoDateStr = [dateFormatter stringFromDate:secondDate];
    NSDate *oneDate = [dateFormatter dateFromString:oneDateStr];
    NSDate *twoDate = [dateFormatter dateFromString:twoDateStr];
    NSComparisonResult result = [oneDate compare:twoDate];
    if (result == NSOrderedAscending) {
        return -1;
    }else if (result == NSOrderedDescending) {
        return 1;
    }else{
        return 0;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation LhCalendarModel

@end
