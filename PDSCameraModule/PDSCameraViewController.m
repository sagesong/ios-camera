//
//  PdSCameraViewController.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "PDSCameraViewController.h"
#import "CameraView.h"
#import "CameraSessionManage.h"
#import "CameraOverLayerView.h"
#import "Masonry.h"
#import "CamrePreviewController.h"
@interface PDSCameraViewController ()<CameraTopViewDelegate>

@property (nonatomic, strong) CameraSessionManage *manager;
@property (nonatomic, strong) CamrePreviewController *pre;
@end

@implementation PDSCameraViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CameraSessionManage *manage = [[CameraSessionManage alloc] init];
    self.manager = manage;
    CamrePreviewController *pre = [[CamrePreviewController alloc] init];
    self.pre = pre;
    [self.view addSubview:pre.view];
    CameraView *cameraView = (CameraView *)pre.view;
    [cameraView setSession:manage.session];
    [self addChildViewController:pre];
    CameraOverLayerView *overLayer = [[CameraOverLayerView alloc] init];
    overLayer.topView.delegate = self;
    [self.view addSubview:overLayer];

    [overLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.pre.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.manager startRunning];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        

    } else if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.pre.view.transform = CGAffineTransformIdentity;
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.pre.view.transform = CGAffineTransformRotate(self.pre.view.transform, -M_PI_2);
    }

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
//        self.pre.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
        self.pre.view.transform = CGAffineTransformRotate(self.pre.view.transform, M_PI_2);
    }
    
//    [self.pre.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    [self.view layoutIfNeeded];
}

#pragma mark - Camera view delegate
- (void)backBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)flashBtnClicked:(BOOL)enableFlash
{
    
}
- (void)microBtnClicked:(BOOL)enableMicro
{
    
}
- (void)switchBtnClicked
{
    [self.manager switchCamera];
}



@end
