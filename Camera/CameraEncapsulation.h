//
//  CameraEncapsulation.h
//  Camera
//
//  Created by r_zhou on 15/12/3.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CameraEncapsulation;

@protocol CameraEncapsulationDelegate <NSObject>


-(void)CameraEncapsulation:(NSData *)data UIImage:(UIImage *)image;

@end

@interface CameraEncapsulation : UIViewController
- (void)camer:(UIViewController *)view;

@property (retain,nonatomic) id <CameraEncapsulationDelegate> delegate;
@end
