//
//  CameraEncapsulation.m
//  Camera
//
//  Created by r_zhou on 15/12/3.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import "CameraEncapsulation.h"

@interface CameraEncapsulation ()
<UINavigationControllerDelegate,
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@end

@implementation CameraEncapsulation


- (void)camer:(UIViewController *)view ;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [self LocalPhoto:view];
    }];
    UIAlertAction *resrtAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self takePhoto:view];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    
    [alertController addAction:defaultAction];
    [alertController addAction:resrtAction];
    [alertController addAction:cancelAction];
    
    //弹出视图 使用UIViewController的方法
    [view presentViewController:alertController animated:YES completion:nil];

}

//从相册选择
-(void)LocalPhoto:(UIViewController *)view{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [view presentViewController:picker animated:YES completion:nil];
}

//拍照
-(void)takePhoto:(UIViewController *)view{
    
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [view presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
}

- (void)showTakePhoto:(id)target isCamera:(BOOL)isCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (!isCamera) {//拍照
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = target;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [target presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        
        UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 1, image.size.width * 1)];
        NSData *buffer = UIImageJPEGRepresentation(newImage, 0.5);
        NSString *type = @"image/jpg";
        if (buffer == nil) {
            buffer = UIImagePNGRepresentation(newImage);
            type = @"image/png";
        }

    
        if ([_delegate respondsToSelector:@selector(CameraEncapsulation:UIImage:)]) {
            [_delegate CameraEncapsulation:buffer UIImage:newImage];
        
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
    }
 
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
