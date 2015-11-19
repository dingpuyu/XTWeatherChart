#import <Foundation/Foundation.h>

@interface NSDate (LYZExtension)
// 格式化时间
// --年--月--日--时--分--秒
// 年 y
// 月 M
// 日 d
// 时 H 大写代表24小时 小写代表12小时制
// 分 m
// 秒 s


-(NSInteger)year;
-(NSInteger)month;
-(NSInteger)day;
-(NSInteger)minute;
-(NSInteger)hour;
-(NSInteger)second;
//纳秒
- (NSInteger)nanosecond;
//顺序
- (NSInteger)weekday;
//属于第几周
- (NSInteger)weekdayOrdinal;

- (NSInteger)quarter;

- (NSInteger)weekOfMonth;

- (NSInteger)weekOfYear;

- (NSInteger)yearForWeekOfYear;
//是否闰月
- (BOOL)leapMonth;
@end