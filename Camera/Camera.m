//
//  Camera.m
//  Camera
//
//  Created by lius on 15/12/24.
//  Copyright © 2015年 lius. All rights reserved.
//

#import "Camera.h"

@implementation Camera 

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    keyAnima = [CAKeyframeAnimation animation];
    //初始化相机
    camer = [[CameraEncapsulation alloc]init];
    camer.delegate = self;
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    [self addSubview:self.scrollView];
    imageWidth = (SCREEN_WIDTH - 70)/4;
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(20 , 20 , imageWidth, imageWidth)];
    [self.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.addButton];
    self.scrollView.backgroundColor = [UIColor grayColor];
    if (!_imageArray) {
        NSLog(@"%@",_imageArray);
    }
}

- (void)addImage:(UIButton *)sender
{
    [camer camer:self.controll];
    
}

#pragma mark 添加图片
- (void)setImageViews:(NSMutableArray *)array{
    self.imgView = [[UIView alloc]initWithFrame:self.scrollView.bounds];
    self.imgView.autoresizesSubviews = NO;
    self.addButton.hidden = NO;
    for (int i = 0; i < array.count; i ++) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * (10+imageWidth), 15 , imageWidth, imageWidth)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView setImage:array[i]];
        self.imageView.tag = 1000+i;
        [self.imgView addSubview:self.imageView];
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [longPressRecognizer setMinimumPressDuration:1.0];
        [self.imageView addGestureRecognizer:longPressRecognizer];
        
        self.addButton.frame = CGRectMake(10 + (i+1) * (10+imageWidth), 15 , imageWidth, imageWidth);
        
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        float w = 20;
        float h = 20;
        
        [_delButton setFrame:CGRectMake(self.imageView.frame.size.width-20,0, w, h)];
        [_delButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _delButton.backgroundColor = [UIColor clearColor];
        [_delButton addTarget:self action:@selector(removeImageClicked:) forControlEvents:UIControlEventTouchUpInside];
        _delButton.tag = i;
        _delButton.hidden = YES;
        [self.imageView addSubview:_delButton];
        
    }
    
    if(array.count == 4)//设置可以放多少张图片
    {
        self.addButton.hidden = YES;
    }
    if (array.count == 0) {
        
        self.addButton.frame = CGRectMake(10 , 15 , imageWidth, imageWidth);
    }
    [self.imgView addSubview:self.addButton];
    [self.scrollView addSubview:self.imgView];
    
    //计算scrollview的滚动范围
    /**
     *  @author lius, 15年-12月-24日 15:12:00
     *
     *  如果有多张图片可以滚动，待改
     */
//    if(array.count >= 4)
//    {
//        
//        self.scrollView.contentSize =  CGSizeMake(SCREEN_WIDTH + (array.count + 1 - 4) * (imageWidth + 10), [self.scrollView contentSize].height);
//    }else
//    {
//        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, [self.scrollView contentSize].height);
//    }
    
}

#pragma mark 删除图片
-(void)handleLongPress:(UILongPressGestureRecognizer*)recognizer{
    
    //多选
    for (UIView *view in self.imgView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            self.imageView = (UIImageView *)view;
            _delButton = [self.imageView viewWithTag:self.imageView.tag - 1000];
            [self rotation:self.imageView];
            _delButton.hidden = NO;
        }
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [self.controll dismissViewControllerAnimated:YES completion:^(void){}];
}

#pragma mark 删除图片
- (void) removeImageClicked:(UIButton *)sender  {
    
    [_imageArray removeObjectAtIndex:sender.tag];
    [self.imgView removeFromSuperview];
    [self setImageViews:_imageArray];
    [self handleLongPress];
}

#pragma mark 删除图片后保存动画效果
-(void)handleLongPress{
    
    for (UIView *view in self.imgView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            self.imageView = (UIImageView *)view;
            _delButton = [self.imageView viewWithTag:self.imageView.tag - 1000];
            [self rotation:self.imageView];
            _delButton.hidden = NO;
        }
        
    }
}

#pragma mark CameraEncapsulationDelegate
- (void)CameraEncapsulation:(NSData *)data UIImage:(UIImage *)image
{
    [_imageArray addObject:image];
    [self.imgView removeFromSuperview];
    [self setImageViews:_imageArray];
}

#pragma mark 抖动动画
- (void)rotation:(UIImageView *)imageView {
    //1,创建核心动画
    
    
    //2,告诉系统执行什么动画。
    keyAnima.keyPath = @"transform.rotation";
    
    //              (-M_PI_4 /90.0 * 5)表示-5度 。
    keyAnima.values = @[@(-M_PI_4 /90.0 * 5),@(M_PI_4 /90.0 * 5),@(-M_PI_4 /90.0 * 5)];
    
    // 1.2.1执行完之后不删除动画
    keyAnima.removedOnCompletion = NO;
    // 1.2.2执行完之后保存最新的状态
    keyAnima.fillMode = kCAFillModeForwards;
    
    //动画执行时间
    keyAnima.duration = 0.2;
    
    //设置重复次数。
    keyAnima.repeatCount = MAXFLOAT;
    
    // 2.添加核心动画
    [imageView.layer addAnimation:keyAnima forKey:nil];
    
    
    //    CAKeyframeAnimation *frame=[CAKeyframeAnimation animation];
    //    CGFloat left=-M_PI_2*0.125;
    //    CGFloat right=M_PI_2*0.125;
    //
    //
    //    frame.keyPath=@"postion";
    //    frame.keyPath=@"transform.rotation";
    //
    //    frame.values=@[@(left),@(right),@(left)];
    //    frame.duration=0.1;
    //    frame.repeatCount=10;
    //    [imageView.layer addAnimation:frame forKey:nil];
    //
    //    //取消动画
    //    [imageView.layer removeAnimationForKey:@"transform.rotation"];
}


@end
