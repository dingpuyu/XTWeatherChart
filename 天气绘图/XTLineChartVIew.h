//
//  XTLineChartVIew.h
//  天气绘图
//
//  Created by xiaotei on 15/9/24.
//  Copyright (c) 2015年 xiaotei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChartPoint;
@interface XTLineChartVIew : UIScrollView
//绘图点对象数组
@property (nonatomic,strong)NSMutableArray* points;

-(void)addChartPoint:(ChartPoint*)chartPoint;

@end
