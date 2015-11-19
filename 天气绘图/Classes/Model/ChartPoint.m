//
//  ChartPoint.m
//  天气绘图
//
//  Created by xiaotei on 15/9/24.
//  Copyright (c) 2015年 xiaotei. All rights reserved.
//

#import "ChartPoint.h"

@implementation ChartPoint

+(instancetype)chartPointWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
//        计算当前星期几
        NSDate* currentDate = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd"];
        NSString* dateString = [NSString stringWithFormat:@"%d/%@",[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:currentDate].year,self.date];
        _date = dateString;
        NSDate* date = [formatter dateFromString:dateString];
        NSInteger weekDay = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date].weekday;
        weekDay -= 1;
        if (weekDay <= 0) {
            weekDay += 7;
        }
        _weekday = weekDay;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"时间:%@,天象:%@",_date,_sky];
}

@end
