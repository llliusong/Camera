//
//  ViewController.m
//  Camera
//
//  Created by lius on 15/12/24.
//  Copyright © 2015年 lius. All rights reserved.
//

#import "ViewController.h"
#import "CameraEncapsulation.h"
#import "Camera.h"

@interface ViewController ()<CameraEncapsulationDelegate,CameraDelegate>
{
    CameraEncapsulation *camer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setFrame:CGRectMake(100, 100, 100, 30)];
//    [button setTitle:@"添加" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    self.navigationController.navigationBar.translucent = NO;
    Camera *car = [[Camera alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 150)];
    car.delegate = self;
    car.controll = self;
    [self.view addSubview:car];
    
    //初始化相机
    camer = [[CameraEncapsulation alloc]init];
    camer.delegate = self;
}

- (void)CameraAddImageBUtton
{
    [camer camer:self];
}

- (void)addImage:(UIButton *)sender
{
    [camer camer:self];
}

- (void)CameraEncapsulation:(NSData *)data UIImage:(UIImage *)image
{
    NSLog(@"%@",data);
    NSLog(@"%@",image);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
