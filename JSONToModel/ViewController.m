//
//  ViewController.m
//  JSONToModel
//
//  Created by Alimjan on 15/11/19.
//  Copyright © 2015年 Alimjan. All rights reserved.
//

#import "ViewController.h"
#import "ModelTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *strJSON = @"{\"weather\":[{\"names\":\"china\",\"data\":[\"2℃\",\"-2℃\",\"1℃\",\"11℃\",\"-1℃\",\"1℃\"],\"times\":[10,11,12,13,14,15]},{\"names\":\"america\",\"data\":[\"2℃\",\"-12℃\",\"11℃\",\"0℃\",\"-1℃\",\"1℃\"],\"times\":[10,11,12,13,14,15]}]}";
    
    
    
    
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:[strJSON dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",[ModelTool doHParse:weatherDic modelName:@"WeatherModel"]);
    NSLog(@"%@",[ModelTool doMParse:weatherDic modelName:@"WeatherModel"]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
