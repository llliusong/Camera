//
//  Camera.h
//  Camera
//
//  Created by lius on 15/12/24.
//  Copyright © 2015年 lius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraEncapsulation.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@protocol CameraDelegate <NSObject>

/**
 *  @author lius, 15年-12月-24日 15:12:41
 *
 *  代理，点击添加按钮实现的方
 */
-(void)CameraAddImageBUtton;

@end

@interface Camera : UIView<CameraEncapsulationDelegate>
{
    CGFloat imageWidth;//图片宽高
    
    CAKeyframeAnimation *keyAnima;
    
//    NSMutableArray *imageArray;
    
    CameraEncapsulation *camer;
}
@property (nonatomic,strong) UIViewController *controll;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *imgView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UIButton *delButton;
@property (nonatomic,strong) NSMutableArray *imageArray;

@property (retain,nonatomic) id <CameraDelegate> delegate;
@end
