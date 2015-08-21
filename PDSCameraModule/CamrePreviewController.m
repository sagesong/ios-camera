//
//  CamrePreviewController.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/21.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CamrePreviewController.h"
#import "CameraView.h"

@implementation CamrePreviewController
- (void)loadView
{
    self.view = [[CameraView alloc] init];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.view.frame = [UIScreen mainScreen].bounds;
//}



@end
