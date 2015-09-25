//
//  NSDate+LYZExtension.m
//  AppProject
//
//  Created by 刘育哲 on 15/4/8.
//  Copyright (c) 2015年 刘育哲. All rights reserved.
//

#import "NSDate+LYZExtension.h"

@implementation NSDate (LYZExtension)

- (NSInteger)year
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self].year;
}

- (NSInteger)month
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self].month;
}

- (NSInteger)day
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self].day;
}

- (NSInteger)hour
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self].hour;
}

- (NSInteger)minute
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self].minute;
}

- (NSInteger)second
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self].second;
}

- (NSInteger)nanosecond
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self].nanosecond;
}

- (NSInteger)weekday
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self].weekday;
}

- (NSInteger)weekdayOrdinal
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self].weekdayOrdinal;
}

- (NSInteger)quarter
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self].quarter;
}

- (NSInteger)weekOfMonth
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self]. weekOfMonth;
}

- (NSInteger)weekOfYear
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self].weekOfYear;
}

- (NSInteger)yearForWeekOfYear
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self].yearForWeekOfYear;
}

- (BOOL)leapMonth
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self].leapMonth;
}

@end