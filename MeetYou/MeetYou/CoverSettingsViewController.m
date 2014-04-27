//
//  CoverSettingsViewController.m
//  MeetYou
//
//  Created by tianliwei on 27/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import "CoverSettingsViewController.h"

@interface CoverSettingsViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation CoverSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self openPics];
    }else if (buttonIndex == 1){
        [self openCamera];
    }
}

// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

// 打开相册
- (void)openPics {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
    }];
}

// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@", info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSLog(@"found an image");
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        NSLog(@"%@",imageFile);
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        // UIImagePickerControllerOriginalImage 原始图片
        // UIImagePickerControllerEditedImage 编辑后图片
        [self.coverButton setBackgroundImage:image forState:UIControlStateNormal];
        [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFile atomically:YES];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"使用手机拍照", nil];
    [sheet showInView:self.view];
}

@end
