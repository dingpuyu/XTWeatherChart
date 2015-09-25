//
//  ViewController.m
//  天气绘图
//
//  Created by xiaotei on 15/9/24.
//  Copyright (c) 2015年 xiaotei. All rights reserved.
//

#import "ViewController.h"
#import "XTLineChartVIew.h"
#import "ChartPoint.h"
#import "NSDate+LYZExtension.h"

@interface ViewController ()
@property (nonatomic,strong)NSArray* chartPointsArray;
@end

@implementation ViewController

-(NSArray *)chartPointsArray{
    if (_chartPointsArray == nil) {
        NSMutableArray* arrayM = [NSMutableArray array];
        
        NSString* path = [[NSBundle mainBundle]pathForResource:@"weather" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray* objsArray = dict[@"result"][@"days"];
        for (NSDictionary* objDict in objsArray) {
            ChartPoint* chartPoint = [ChartPoint chartPointWithDict:objDict];
            [arrayM addObject:chartPoint];
        }
        _chartPointsArray = arrayM;
    }
    return _chartPointsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XTLineChartVIew* lineChart = [[XTLineChartVIew alloc]init];
    lineChart.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    
    [self.view addSubview:lineChart];
    lineChart.points = [self.chartPointsArray copy];
    
//    NSDate* date = [NSDate date];
//    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-DD-"];
//    date = [formatter dateFromString:@"2011-11-21"];
//    NSDate *  senddate=[NSDate date];
    
//    NSLog(@"%d",[date minute]);
 
}

-(void)time{
    NSDate* date = [[NSDate alloc]init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-DD"];
    date = [formatter dateFromString:@"2011-11-21"];
    //    NSDate *  senddate=[NSDate date];
    
    NSLog(@"%d",[date year]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
