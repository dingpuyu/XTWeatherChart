//
//  ChartPoint.h
//  天气绘图
//
//  Created by xiaotei on 15/9/24.
//  Copyright (c) 2015年 xiaotei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChartPoint : NSObject


//时间
@property (nonatomic,copy)NSString* date;
//最高气温
@property (nonatomic,copy)NSString* maxTmp;
//最低气温
@property (nonatomic,copy)NSString* minTmp;

@property (nonatomic,assign)NSInteger run;
//天空
@property (nonatomic,copy)NSString* sky;
//风
@property (nonatomic,copy)NSString* wind;

@property (nonatomic,assign)NSInteger weekday;
//中点
@property (nonatomic,assign)CGPoint centerMax;
@property (nonatomic,assign)CGPoint centerMin;

+(instancetype)chartPointWithDict:(NSDictionary*)dict;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
