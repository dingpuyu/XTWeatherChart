//
//  XTLineChartVIew.m
//  天气绘图
//
//  Created by xiaotei on 15/9/24.
//  Copyright (c) 2015年 xiaotei. All rights reserved.
//

#import "XTLineChartVIew.h"
#import "NSDate+LYZExtension.h"
#import "ChartPoint.h"

#define ItemWidth (int)([UIScreen mainScreen].bounds.size.width / 5)
#define CircleRadius  8

@interface XTLineChartVIew()

@property (nonatomic,assign)CGPoint point;
@property (nonatomic,assign)CGFloat contentScroll;
//温度底线
@property (nonatomic,assign)CGFloat baseLine;

//温度缩放比例
@property (nonatomic,assign)CGFloat sizeScaleProportion;
@end

@implementation XTLineChartVIew
//0°线值懒加载
-(CGFloat)baseLine{
    if (_baseLine == 0) {
        _baseLine = self.frame.size.height * 0.3;
    }
    return _baseLine;
}
//温度数据与视图尺寸缩放比例
-(CGFloat)sizeScaleProportion{
    if (_sizeScaleProportion == 0) {
        _sizeScaleProportion = self.frame.size.height/65.0f;
    }
    return _sizeScaleProportion;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    self.backgroundColor = [UIColor whiteColor];
    _point = CGPointZero;
    /**
     *  为自身添加监听事件，监听contentOffset属性
     */
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _contentScroll = 0;
}



-(UIColor*)randonColor{
    
    /**
     *      颜色的表现形式RGB和RGBA
     *      RGB 24位
     *      RGB每个颜色通道有八位
     *      8的二进制是255
     *      R,G,B每个颜色取值0~255
     *      RGBA是32位
     */
    
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

#warning 仍然有个bug，无法很好地让点早一些显示 问题在于判断偏移量
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat startW = 1;
    CGFloat startH = self.frame.size.height;
    
    int startX  = (int)self.contentOffset.x  / ItemWidth;
    int enxX = (int)(self.contentOffset.x + self.frame.size.width + ItemWidth)/ItemWidth;
    if (self.points.count <= 0)return;
    for (int i = startX; i < enxX ; i++) {
//        当结束点大于最大点数量时 结束
        if (i >= _points.count)return;
        ChartPoint* chartPoint = _points[i];
//        绘制竖线
        CGContextRef contexRef = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(contexRef, ItemWidth * i, 0);
        CGContextSetLineWidth(contexRef, startW);
//        CGContextAddLineToPoint(contexRef, 0, 0);
        
        CGContextAddLineToPoint(contexRef,ItemWidth * i, startH);
        
        CGContextSetStrokeColorWithColor(contexRef, [UIColor lightGrayColor].CGColor);
        
        CGContextStrokePath(contexRef);
        
        
//        绘制圆点
        contexRef = UIGraphicsGetCurrentContext();
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){{chartPoint.centerMax.x - CircleRadius / 2.0,chartPoint.centerMax.y - CircleRadius / 2.0},{CircleRadius,CircleRadius}}];
        [UIColor.redColor setFill];
        [ovalPath fill];
        
        contexRef = UIGraphicsGetCurrentContext();
        ovalPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){{chartPoint.centerMin.x - CircleRadius / 2.0,chartPoint.centerMin.y - CircleRadius / 2.0},{CircleRadius,CircleRadius}}];
        [[UIColor colorWithRed:0.35f green:0.54f blue:0.64f alpha:1.00f] setFill];
        [ovalPath fill];
    
        NSDictionary* attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName: UIColor.redColor};
        CGRect maxTmpRect = CGRectMake(chartPoint.centerMax.x - 10, chartPoint.centerMax.y - 33, 30, 30);
        [[NSString stringWithFormat:@"%@°",chartPoint.maxTmp] drawInRect:maxTmpRect withAttributes:attribute];
        
        attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor colorWithRed:0.35f green:0.54f blue:0.64f alpha:1.00f]};
        CGRect minTmpRect = CGRectMake(chartPoint.centerMin.x - 10, chartPoint.centerMin.y + 13, 30, 30);
        [[NSString stringWithFormat:@"%@°",chartPoint.minTmp] drawInRect:minTmpRect withAttributes:attribute];
        
//        连线 --- MaxTmp
        contexRef = UIGraphicsGetCurrentContext();
//额，y写错成了，找懵逼
//        CGContextMoveToPoint(contexRef, chartPoint.centerMax.x, chartPoint.centerMax.x);
        CGContextMoveToPoint(contexRef, chartPoint.centerMax.x, chartPoint.centerMax.y);
        CGContextSetLineWidth(contexRef, startW);
        //        CGContextAddLineToPoint(contexRef, 0, 0);
        if (i != startX) {
            ChartPoint* previousPoint = _points[i - 1];
            CGContextAddLineToPoint(contexRef,previousPoint.centerMax.x,previousPoint.centerMax.y);
        }else CGContextAddLineToPoint(contexRef,0,chartPoint.centerMax.y);
        
        CGContextSetStrokeColorWithColor(contexRef, [UIColor redColor].CGColor);
        
        CGContextStrokePath(contexRef);
        
//        蓝线
        
        contexRef = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(contexRef, chartPoint.centerMin.x, chartPoint.centerMin.y);
        CGContextSetLineWidth(contexRef, startW);
        //        CGContextAddLineToPoint(contexRef, 0, 0);
        if (i != startX) {
            ChartPoint* previousPoint = _points[i - 1];
            CGContextAddLineToPoint(contexRef,previousPoint.centerMin.x,previousPoint.centerMin.y);
        }else CGContextAddLineToPoint(contexRef,0,chartPoint.centerMin.y);
        
        CGContextSetStrokeColorWithColor(contexRef, [UIColor colorWithRed:0.35f green:0.54f blue:0.64f alpha:1.00f].CGColor);
        
        CGContextStrokePath(contexRef);
        
        
    }
    
    
#pragma mark 判断是否当日

//    NSLog(@"width%f",self.frame.size.width);
}

//创建了监听才会触发这个事件
-(void)willChangeValueForKey:(NSString *)key{
    if ([key isEqualToString:@"contentOffset"]) {
        [self setNeedsDisplay];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma mark - setter
-(void)setPoints:(NSMutableArray *)points{
    _points = points;
    
    for (int i = 0; i < points.count; i++) {
        ChartPoint * chartPoint = points[i];
        
        CGFloat circleY = self.frame.size.height - self.sizeScaleProportion *[chartPoint.maxTmp floatValue] - self.baseLine;
        CGFloat circleX = i * ItemWidth + ItemWidth/2;
        chartPoint.centerMax = CGPointMake(circleX, circleY);
        
        circleY = self.frame.size.height - self.sizeScaleProportion *[chartPoint.minTmp floatValue] - self.baseLine;
        circleX = i * ItemWidth + ItemWidth/2;
        chartPoint.centerMin = CGPointMake(circleX, circleY);
        
        
    }
//在传递数据的时候进行属性设置，关闭弹性，设置滚动范围
    self.bounces = NO;
    self.contentSize = CGSizeMake(_points.count * ItemWidth,0);
//
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    
//}

-(void)dealloc{
//    移除监听事件
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)addChartPoint:(ChartPoint *)chartPoint{
    [self.points addObject:chartPoint];
}
@end
